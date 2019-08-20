//
//  NowPlayingViewModel.swift
//  mvvm-movies
//
//  Created by Rodrigo Giglio on 16/08/19.
//  Copyright © 2019 Guilherme Piccoli. All rights reserved.
//

import Foundation

class MovieListViewModel {
    
    private var nowPlayingList : [Movie]?
    var downloadDelegate: DownloadDelegate?
    
    init() {
        fetchNowPlayingMovies()
    }
    
    func fetchNowPlayingMovies(){
        DataAccess.getNowPlayingMovies { (listMovies) in
            let result = listMovies?.results ?? []
            self.nowPlayingList = result
            self.downloadDelegate?.didFinishDownload()
        }
    }
    
    public func getCover(byIndexPath index: Int) -> String {
        guard let cover =  nowPlayingList?[index].posterPath else {return ""}
        return cover
    }
    
    public func getTitle(byIndexPath index: Int) -> String {
        guard let title =  nowPlayingList?[index].title else {return ""}
        return title
    }
    
    public func getPopularity(byIndexPath index: Int) -> String {
        let popularity =  String(format: "%.1f", nowPlayingList?[index].voteAverage ?? 100)
        return popularity
    }
    
    public func getMovieID(byIndexPath index: Int) -> Int {
        guard let id =  nowPlayingList?[index].id else {return 0}
        return id
    }
    
    public func getMoviesCount() -> Int {
        return nowPlayingList?.count ?? 0
    }
}

