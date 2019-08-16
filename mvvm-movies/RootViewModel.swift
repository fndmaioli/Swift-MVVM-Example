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
        DataAccess.getPopularMovies { (listMovies) in
            let result = listMovies?.results ?? []
            self.listPopularMovies = result
            self.downloadDelegate?.didFinishDownload()
        }
    }
    
    func fetchSearchMovies(name: String){
        DataAccess.getMovies(named: name, completionHandler: { (listSearch) in
            let result = listSearch?.results ?? []
            self.listSearchMovies = result
            self.downloadDelegate?.didFinishDownload()
        })
    }
    
    public func getCover(byIndexPath index: Int) -> String {
        guard let cover = listPopularMovies?[index].posterPath else {return ""}
        return cover
    }
    
    public func getTitle(byIndexPath index: Int) -> String {
        guard let title =  listPopularMovies?[index].title else {return ""}
        return title
    }
    
    public func getOverview(byIndexPath index: Int) -> String {
        guard let overview =  listPopularMovies?[index].overview else {return ""}
        return overview
    }
    
    public func getPopularity(byIndexPath index: Int) -> String {
        let popularity =  String(format: "%.1f", listPopularMovies?[index].voteAverage ?? 100)
        return popularity
    }
    
    public func getPopularMoviesCount() -> Int {
        return listPopularMovies?.count ?? 0
    }
    
    public func getMovieID(byIndexPath index: Int) -> Int {
        guard let id =  listPopularMovies?[index].id else {return 0}
        return id
    }
    
    
    
}
