//
//  RootViewModel.swift
//
//  Created by Fernando Locatelli Maioli on 17/04/19.
//  Copyright © 2019 Fernando Locatelli Maioli. All rights reserved.
//
import Foundation
import UIKit

class RootViewModel {
    
    private var helloMVVM: HelloWorldExample?
    private var listPopularMovies: [Movie]?
    private var listNowPlayingMovies: [Movie]?
    
    init(){
        helloMVVM = HelloWorldExample(name: "World")
    }
    
    func fetchPopularMovies(){
        DataAccess.getPopularMovies { (listMovies) in
            let result = listMovies?.results ?? []
            self.listPopularMovies = result
        }
    }
    
    func fetchNowPlayingMovies(){
        DataAccess.getNowPlayingMovies { (listMovies) in
            let result = listMovies?.results ?? []
            self.listNowPlayingMovies = result
        }
    }
        
    func getHelloName() -> String {
        guard let helloMVVM = helloMVVM else { return "" }
        return helloMVVM.name
    }
    
    
}
