//
//  NowPlayingTableViewCell.swift
//  mvvm-movies
//
//  Created by Rodrigo Giglio on 15/08/19.
//  Copyright © 2019 Guilherme Piccoli. All rights reserved.
//

import UIKit

class NowPlayingTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var viewModel : MovieListViewModel?
    var detailSegueDelegate: DetailMovieSegue?
    
    
    @IBOutlet weak var nowPlayingCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewModel = MovieListViewModel()
        viewModel?.downloadDelegate = self
        nowPlayingCollectionView.delegate = self
        nowPlayingCollectionView.dataSource = self
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
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
            let data = try! Data(contentsOf: imageUrl!)
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
        
        detailSegueDelegate?.didNavigateDetail(movieId: movieID)
        
    }

}

protocol DownloadDelegate {
    func didFinishDownload()
}

protocol DetailMovieSegue {
    func didNavigateDetail(movieId: Int)
}

extension NowPlayingTableViewCell : DownloadDelegate {
    func didFinishDownload() {
                
        DispatchQueue.main.async {
            self.nowPlayingCollectionView.reloadData()
        }
    }
}
