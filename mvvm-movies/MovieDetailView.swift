//
//  MovieDetailView.swift
//  mvvm-movies
//
//  Created by Rodrigo Giglio on 16/08/19.
//  Copyright © 2019 Guilherme Piccoli. All rights reserved.
//

import UIKit

class MovieDetailView: UIViewController {
    
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var genres: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    
    var viewModel : DetailViewModel?
    var id : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel = DetailViewModel(id: self.id!)
        
        guard let viewModel = self.viewModel else {return}
        movieTitle.text = viewModel.getTitle()
        rating.text = viewModel.getPopularity()
        overview.text = viewModel.getOverview()
        genres.text = viewModel.getGenres()
        
        let imagePath = viewModel.getCover()
        
        if imagePath == "" {return}
        
        let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500" + (imagePath))
        DispatchQueue.global(qos: .background).async {
            let data = try! Data(contentsOf: imageUrl!)
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.cover.image = image
            }
        }
        
        
    }

}
