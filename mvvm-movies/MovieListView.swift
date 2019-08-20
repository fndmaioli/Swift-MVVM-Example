//
//  SeeAllNowPlayingView.swift
//  mvvm-movies
//
//  Created by Guilherme Piccoli on 20/08/19.
//  Copyright © 2019 Guilherme Piccoli. All rights reserved.
//

import UIKit

class MovieListView: UIViewController {
    
    @IBOutlet var resultsCountLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    private var viewModel: MovieListViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = MovieListViewModel()
        viewModel?.downloadDelegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}


extension MovieListView: UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.getMoviesCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell else {return UICollectionViewCell()}
        
        guard  let viewModel = self.viewModel else {return cell}
        cell.movieTitle.text = viewModel.getTitle(byIndexPath: indexPath.row)
        cell.rating.text = viewModel.getPopularity(byIndexPath: indexPath.row)
        
        let imagePath = viewModel.getCover(byIndexPath: indexPath.row)
        
        if imagePath == "" {return cell}
        
        let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500" + (imagePath))
        DispatchQueue.global(qos: .background).async {
            guard let data = try? Data(contentsOf: imageUrl!) else {return}
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                cell.cover.image = image
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = self.viewModel else {return}
        let movieID = viewModel.getMovieID(byIndexPath: indexPath.row)
        
        performSegue(withIdentifier: "movieDetail", sender: movieID)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let movieId = sender as? Int {
            if let movieDetailView = segue.destination as? DetailView {
                movieDetailView.id = movieId
            }
        }
    }
    
}

extension MovieListView: DownloadDelegate {
    func didFinishDownload() {
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            guard let viewModel = self.viewModel else {return}
            self.resultsCountLabel.text = "Showing \(viewModel.getMoviesCount()) results"
        }
    }
}
