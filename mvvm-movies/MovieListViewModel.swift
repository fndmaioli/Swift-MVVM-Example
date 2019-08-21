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
    private var currentPage : Int = 1
    var downloadDelegate: DownloadDelegate?
    
    init() {
        nowPlayingList = []
        fetchNowPlayingMovies()
    }
    
    func fetchNowPlayingMovies(for indexPath : IndexPath) {
        let currentIndex = indexPath.row + 1
        
        if currentIndex/20 == currentPage {
            currentPage += 1
            fetchNowPlayingMovies()
        }
    }
    
    func fetchNowPlayingMovies() {
        DataAccess.getNowPlayingMovies(fromPage: currentPage) { (listMovies) in
            let result = listMovies?.results ?? []
            self.nowPlayingList!.append(contentsOf: result)
            self.downloadDelegate?.didFinishDownload()
        }
    }
    
    public func getCover(byIndexPath index: Int) -> String {
        guard !nowPlayingList!.isEmpty, let cover =  nowPlayingList?[index].posterPath else {return ""}
        return cover
    }
    
    public func getTitle(byIndexPath index: Int) -> String {
        guard !nowPlayingList!.isEmpty, let title =  nowPlayingList?[index].title else {return ""}
        return title
    }
    
    public func getPopularity(byIndexPath index: Int) -> String {
        guard !nowPlayingList!.isEmpty, let rating = nowPlayingList?[index].voteAverage else {return ""}
        let popularity =  String(format: "%.1f", rating)
        return popularity
    }
    
    public func getMovieID(byIndexPath index: Int) -> Int {
        guard !nowPlayingList!.isEmpty, let id =  nowPlayingList?[index].id else {return 0}
        return id
    }
    
    public func getMoviesCount() -> Int {
        return nowPlayingList?.count ?? 0
    }
}

