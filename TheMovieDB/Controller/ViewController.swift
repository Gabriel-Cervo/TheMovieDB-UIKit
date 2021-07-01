//
//  ViewController.swift
//  TheMovieDB
//
//  Created by Joao Gabriel Dourado Cervo on 30/06/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var popularMovies: [Movie] = []
    var playingMovies: [Movie] = []
    
    let headerTitles: [String] = ["Popular Movies", "Now Playing"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
            
        
        DataManager.shared.getData(from: "https://api.themoviedb.org/3/movie/popular?api_key=a0302297acdf27ae50ba169f78c8ed74") { [weak self] movies in
            self?.popularMovies = movies
            self?.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        }
        
        DataManager.shared.getData(from: "https://api.themoviedb.org/3/movie/now_playing?api_key=a0302297acdf27ae50ba169f78c8ed74") { [weak self] movies in
            self?.playingMovies = movies
            self?.tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieTableViewCell
        let movie: Movie = indexPath.section == 0 ? popularMovies[indexPath.row] : playingMovies[indexPath.row]
        
        cell.configure(image: UIImage(systemName: "star")!, title: movie.title, description: movie.overview, rating: movie.vote_average)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerTitles[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return popularMovies.count
        }
        
        return playingMovies.count
    }
}

