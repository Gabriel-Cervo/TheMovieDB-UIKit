//
//  Movie.swift
//  TheMovieDB
//
//  Created by Joao Gabriel Dourado Cervo on 30/06/21.
//

import UIKit

struct Movie: Decodable {
    var title: String
    var overview: String
    var poster_path: String
    var vote_average: Double
    var genre_ids: [Int]
}
