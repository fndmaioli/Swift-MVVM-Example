//
//  RootViewModel.swift
//
//  Created by Fernando Locatelli Maioli on 17/04/19.
//  Copyright © 2019 Fernando Locatelli Maioli. All rights reserved.
//
import Foundation
import UIKit

class RootViewModel {
    
    private var listPopularMovies: [Movie]?
    private var listNowPlayingMovies: [Movie]?
    private var listSearchMovies: [Movie]?
    
    var downloadDelegate: DownloadDelegate?
    
    init() {
        fetchPopularMovies()
    }

    func fetchPopularMovies(){
//        DataAccess.getPopularMovies { (listMovies) in
//            let result = listMovies?.results ?? []
//            self.listPopularMovies = self.orderByRating(movieList: result)
//
//            self.downloadDelegate?.didFinishDownload()
//        }
        
        APIService().getPopularMovies { (array) in
            if let movieList = array as? [Movie] {
                self.listPopularMovies = self.orderByRating(movieList: movieList)
                self.downloadDelegate?.didFinishDownload()
            } else {
                self.listPopularMovies = []
            }
        }
    }
    
    func orderByRating(movieList: [Movie]) -> [Movie] {
        return movieList.sorted(by: {$0.rating.doubleValue > $1.rating.doubleValue})
    }
    
    func fetchSearchMovies(name: String){
//        DataAccess.getMovies(named: name, completionHandler: { (listSearch) in
//            let result = listSearch?.results ?? []
//            self.listSearchMovies = result
//            self.downloadDelegate?.didFinishDownload()
//        })
    }
    
    public func getCover(byIndexPath index: Int) -> String {
        guard let cover = listPopularMovies?[index].image else {return ""}
        return cover
    }
    
    public func getTitle(byIndexPath index: Int) -> String {
        guard let title =  listPopularMovies?[index].name else {return ""}
        return title
    }
    
    public func getOverview(byIndexPath index: Int) -> String {
        guard let overview =  listPopularMovies?[index].description else {return ""}
        return overview
    }
    
    public func getPopularity(byIndexPath index: Int) -> String {
        let popularity =  String(format: "%.1f", listPopularMovies?[index].rating ?? 100)
        return popularity
    }
    
    public func getPopularMoviesCount() -> Int {
        return listPopularMovies?.count ?? 0
    }
    
    public func getMovieID(byIndexPath index: Int) -> Int {
        guard let id =  listPopularMovies?[index].id_movie else {return 0}
        return Int(id) ?? 0
    }
    
    
    
}
