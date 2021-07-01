//
//  DetailContentTableViewCell.swift
//  TheMovieDB
//
//  Created by Joao Gabriel Dourado Cervo on 30/06/21.
//

import UIKit

class DetailContentTableViewCell: UITableViewCell {
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configure(description: String) {
        self.descriptionLabel.text = description
    }
}
