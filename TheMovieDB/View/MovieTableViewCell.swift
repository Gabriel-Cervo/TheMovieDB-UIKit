//
//  MovieTableViewCell.swift
//  TheMovieDB
//
//  Created by Joao Gabriel Dourado Cervo on 30/06/21.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(imageLink: String, title: String, description: String, rating: Double) {
        self.movieTitle.text = title
        self.movieDescription.text = description
        self.movieRating.text = "\(rating)"
        self.movieImageView.imageFromServerURL(imageLink, placeHolder: UIImage(named: "imagePlaceholder"))
    }
}
