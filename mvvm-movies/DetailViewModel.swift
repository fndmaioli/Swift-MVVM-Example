//
//  DetailViewModel.swift
//  mvvm-movies
//
//  Created by Rodrigo Giglio on 16/08/19.
//  Copyright © 2019 Guilherme Piccoli. All rights reserved.
//

import Foundation

class DetailViewModel {
    
    private var movieDetail : Movie?
    
    var downloadDelegate : DownloadDelegate?
    
    init(id: Int) {
        fetchMovieDetail(withId: id)
    }
    
    func fetchMovieDetail(withId id: Int){
//        DataAccess.getDetailsMovie(fromId: id) { (movieDetail) in
//
//            guard let movieDetail = movieDetail else {return}
//
//            self.movieDetail = movieDetail
//            self.downloadDelegate?.didFinishDownload()
//        }
        APIService().getMovieDetail({ (movieDetail) in
            guard let movieDetail = movieDetail else {return}
            
            self.movieDetail = movieDetail
            self.downloadDelegate?.didFinishDownload()
        }, movieID: NSNumber(integerLiteral: id))
    }
    
    public func getCover() -> String {
        guard let cover =  movieDetail?.image else {return ""}
        return cover
    }
    
    public func getTitle() -> String {
        guard let title =  movieDetail?.name else {return ""}
        return title
    }
    
    public func getOverview() -> String {
        guard let overview =  movieDetail?.overview else {return ""}
        return overview
    }
    
    public func getGenres() -> String {
//        guard let genres =  movieDetail?.genres else {return ""}
//        let genresString = genres.map { (genre) -> String in
//            return genre.name ?? ""
//            }.joined(separator: ", ")
//        return genresString
        guard let genres = movieDetail?.genres as String? else { return "" }
        return genres
    }
    
    public func getPopularity() -> String {
//        let popularity =  String(format: "%.1f", movieDetail?.voteAverage ?? 100)
//        return popularity
        let popularity = movieDetail?.rating
        return popularity?.stringValue ?? "0"
    }
}
