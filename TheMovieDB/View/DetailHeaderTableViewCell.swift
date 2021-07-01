//
//  DetailHeaderTableViewCell.swift
//  TheMovieDB
//
//  Created by Joao Gabriel Dourado Cervo on 30/06/21.
//

import UIKit

class DetailHeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieTags: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    
    func configure(imageLink: String, title: String, rating: Double) {
        self.movieTitle.text = title
        self.movieRating.text = "\(rating)"
        self.movieImageView.imageFromServerURL(imageLink, placeHolder: UIImage(named: "imagePlaceholder"))
    }
}
