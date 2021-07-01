//
//  DetailViewController.swift
//  TheMovieDB
//
//  Created by Joao Gabriel Dourado Cervo on 30/06/21.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movie = movie else { fatalError("no movie found") }

        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! DetailHeaderTableViewCell
            cell.configure(imageLink: movie.poster_path, title: movie.title, rating: movie.vote_average)
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContentCell") as! DetailContentTableViewCell
        cell.configure(description: movie.overview)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
}
