//
//  DataAccess.swift
//  mvvm-movies
//
//  Created by Guilherme Piccoli on 14/08/19.
//  Copyright © 2019 Guilherme Piccoli. All rights reserved.
//

import Foundation

struct DataAccess {
    
    static let apiKey: String = "edac55baa5247ecf4089bac4553ff6ed"

    static func getPopularMovies(fromPage page: Int = 1, completionHandler completion: @escaping (ListMovie?) -> Void) {
        var request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=en-US&page=\(page)")!)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            guard let error = error
                else {
                    let listMovie = try? JSONDecoder().decode(ListMovie.self, from: data!)
                    completion(listMovie)
                    return
            }
            print(error.localizedDescription)
            completion(nil)
            return
        })
        dataTask.resume()
    }
    
   
    static func getNowPlayingMovies(fromPage page: Int = 1, completionHandler completion: @escaping (ListMovie?) -> Void) {
        var request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)&language=en-US&page=\(page)")!)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            guard let error = error
                else {
                    let listMovie = try? JSONDecoder().decode(ListMovie.self, from: data!)
                    completion(listMovie)
                    return
            }
            print(error.localizedDescription)
            completion(nil)
            return
        })
        dataTask.resume()
    }
    
    static func getDetailsMovie(fromId id: Int, completionHandler completion: @escaping (MovieDetail?) -> Void) {
        var request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=\(apiKey)&language=en-US")!)

        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            guard let error = error
                else {
                    let movieDetail = try? JSONDecoder().decode(MovieDetail.self, from: data!)
                    completion(movieDetail)
                    return
            }
            print(error.localizedDescription)
            completion(nil)
            return
        })
        dataTask.resume()
    }
    
    
    
}
