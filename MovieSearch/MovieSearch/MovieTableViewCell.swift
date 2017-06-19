//
//  MovieTableViewCell.swift
//  MovieSearch
//
//  Created by Ryan Plitt on 6/19/17.
//  Copyright © 2017 Ryan Plitt. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    var movie: Movie? {
        didSet{
            guard let movie = movie else { return }
            DispatchQueue.main.async {
                self.movieTitleLabel.text = movie.title
                self.movieDescriptionLabel.text = movie.description
            }
            MovieController.fetchImageData(for: movie) { (data) in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    self.movieImageView.image = UIImage(data: data)
                }
            }
        }
    }
    

}
