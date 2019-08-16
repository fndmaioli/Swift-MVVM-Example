//
//  DetailViewModel.swift
//  mvvm-movies
//
//  Created by Rodrigo Giglio on 16/08/19.
//  Copyright © 2019 Guilherme Piccoli. All rights reserved.
//

import Foundation

class DetailViewModel {
    
    private var movieDetail : MovieDetail?
    
    var downloadDelegate : DownloadDelegate?
    
    init(id: Int) {
        fetchMovieDetail(withId: id)
    }
    
    func fetchMovieDetail(withId id: Int){
        DataAccess.getDetailsMovie(fromId: id) { (movieDetail) in
            self.movieDetail = movieDetail
            self.downloadDelegate?.didFinishDownload()
        }
    }
    
    public func getCover() -> String {
        guard let cover =  movieDetail?.posterPath else {return ""}
        return cover
    }
    
    public func getTitle() -> String {
        guard let title =  movieDetail?.title else {return ""}
        return title
    }
    
    public func getOverview() -> String {
        guard let overview =  movieDetail?.overview else {return ""}
        return overview
    }
    
    public func getGenres() -> String {
        //TODO
        return "Genres"
    }
    
    public func getPopularity() -> String {
        let popularity =  String(format: "%.1f", movieDetail?.voteAverage ?? 100)
        return popularity
    }
}
