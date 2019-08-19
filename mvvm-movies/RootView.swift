//
//  RootView.swift
//
//  Created by Fernando Locatelli Maioli on 17/04/19.
//  Copyright © 2019 Fernando Locatelli Maioli. All rights reserved.
//

import UIKit

class RootView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    private var viewModel : RootViewModel?
    
    let searchController = UISearchController(searchResultsController: nil)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movie"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
        
        viewModel = RootViewModel()
        viewModel?.downloadDelegate = self
        
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {return 1}
        
        guard let viewModel = self.viewModel else {return 1}
        return viewModel.getPopularMoviesCount()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 315
        default:
            return 138
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NowPlaying") as? NowPlayingTableViewCell else {return UITableViewCell()}
            cell.detailSegueDelegate = self
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Popular") as? PopularTableViewCell else {return UITableViewCell()}
            
            let moviewIndex = indexPath.row
            
            guard let viewModel = self.viewModel else {return cell}
            cell.movieTitle.text = viewModel.getTitle(byIndexPath: moviewIndex)
            cell.overview.text = viewModel.getOverview(byIndexPath: moviewIndex)
            cell.rating.text = viewModel.getPopularity(byIndexPath: moviewIndex)
            
            let imagePath = viewModel.getCover(byIndexPath: moviewIndex)
            
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
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 0 {
//            return "Now Playing"
//        } else {
//            return "Popular Movies"
//        }
    //    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //        if section == 0 {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 18))
        view.backgroundColor = .white
        let label = UILabel(frame: CGRect(x: 20, y: 20, width: 300, height: 50))
        label.font = UIFont(name: ".SFUIText-Semibold", size: 17)
        label.textColor = .black
        view.addSubview(label)
        
        if section == 0 {
            label.text = "Now Playing"
            
            let button = UIButton(frame: CGRect(x: view.frame.size.width - 80 - 10, y: 20, width: 80, height: 50))
            button.setTitle("See All", for: .normal)
            button.setTitleColor(.black, for: .normal)
            view.addSubview(button)
            
            button.addTarget(self, action: #selector(seeAllButtonClick), for: .touchUpInside)
            
        }
        else if section == 1 {
            label.text = "Popular Movies"

        }
        
        return view
        //        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = self.viewModel else {return}
        let movieID = viewModel.getMovieID(byIndexPath: indexPath.row)
        
        performSegue(withIdentifier: "detail", sender: movieID)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let movieId = sender as? Int {
            if let movieDetailView = segue.destination as? MovieDetailView {
                movieDetailView.id = movieId
            }
        }
    }
    
    @objc func seeAllButtonClick(_ sender: UIButton) {
        print("see all clicked")
    }
    
}

extension RootView: DownloadDelegate {
    func didFinishDownload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension RootView: DetailMovieSegue {
    func didNavigateDetail(movieId: Int) {
        performSegue(withIdentifier: "detail", sender: movieId)
    }
}

extension RootView: UISearchResultsUpdating {
    
    
    
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        //filtro
    }
}
