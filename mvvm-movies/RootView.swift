//
//  RootView.swift
//
//  Created by Fernando Locatelli Maioli on 17/04/19.
//  Copyright © 2019 Fernando Locatelli Maioli. All rights reserved.
//

import UIKit

class RootView: UIViewController {
    
    var hello = RootViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("Hello " + hello.getHelloName())
        
        DataAccess.getPopularMovies { (ListMovie) in
            let movies = ListMovie?.results
            
            for m in movies! {
                print(m.title ?? "")
            }
        }
        
        DataAccess.getDetailsMovie(fromId: 466272) { (MovieDetail) in
            print(MovieDetail?.overview ?? "")
        }
        
        DataAccess.getNowPlayingMovies { (ListMovie) in
            let movies = ListMovie?.results
            
            for m in movies! {
                print(m.title ?? "")
            }
        }
    }
    
}
