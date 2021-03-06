//
//  ViewController.swift
//  TheMovieDB
//
//  Created by Joao Gabriel Dourado Cervo on 30/06/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var popularMovies: [Movie] = []
    var playingMovies: [Movie] = []
    
    let headerTitles: [String] = ["Popular Movies", "Now Playing"]
    
    var initialOffset = 0
    var limitOffset = 5
    var itensLimit = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        loadAllMovies()
    }
    
    //MARK: TableView Methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == self.playingMovies.count - 1 {
            self.loadMore()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieTableViewCell
        
        if indexPath.section == 0 && popularMovies.count == 0 {
            return cell
        }
        
        if indexPath.section == 1 && playingMovies.count == 0 {
            return cell
        }
        
        let movie: Movie = indexPath.section == 0 ? popularMovies[indexPath.row] : playingMovies[indexPath.row]
        
        cell.configure(imageLink: movie.poster_path ?? "", title: movie.title, description: movie.overview, rating: movie.vote_average)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.contentView.backgroundColor = .white
        header.textLabel?.textColor = UIColor.black
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return popularMovies.count
        }
        
        return playingMovies.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie: Movie = indexPath.section == 0 ? popularMovies[indexPath.row] : playingMovies[indexPath.row]
        performSegue(withIdentifier: "toDetails", sender: movie)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let movie = sender as? Movie else { return }
        
        guard let nextVC = segue.destination as? DetailViewController else { return }
        nextVC.movie = movie
    }
    
    @objc func refreshTableView(refreshControl: UIRefreshControl) {
        self.tableView.reloadData()
        
        refreshControl.endRefreshing()
    }
    
    // MARK: SearchBar Implementation
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text, text != "" else {
            self.loadPopularMovies()
            return
        }
        
        DataManager.shared.getData(from: "https://api.themoviedb.org/3/search/movie?api_key=a0302297acdf27ae50ba169f78c8ed74&query=\(text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)", startingItem: 0, maxNumberOfItens: itensLimit) { [weak self] movies in
            self?.popularMovies = movies
            self?.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        }
    }
    
    //MARK: Custom Methods
    func loadAllMovies() {
        loadPopularMovies()
        loadPlayingMovies()
    }
    
    func loadPopularMovies() {
        DataManager.shared.getData(from: "https://api.themoviedb.org/3/movie/popular?api_key=a0302297acdf27ae50ba169f78c8ed74", startingItem: 0, maxNumberOfItens: 2) { [weak self] movies in
            self?.popularMovies = movies
            self?.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        }
    }
    
    func loadPlayingMovies() {
        DataManager.shared.getData(from: "https://api.themoviedb.org/3/movie/now_playing?api_key=a0302297acdf27ae50ba169f78c8ed74", startingItem: 0, maxNumberOfItens: 5) { [weak self] movies in
            self?.playingMovies = movies
            self?.tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
        }
    }
    
    func loadMore() {
        if limitOffset * 2 > itensLimit {
            return
        }
        
        initialOffset = limitOffset + 1
        limitOffset *= limitOffset
        
        DataManager.shared.getData(from: "https://api.themoviedb.org/3/movie/now_playing?api_key=a0302297acdf27ae50ba169f78c8ed74", startingItem: initialOffset, maxNumberOfItens: limitOffset) { [weak self] movies in
            for movie in movies {
                self?.playingMovies.append(movie)
            }
            self?.tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
        }
    }
    
    func resetOffsets() {
        initialOffset = 0
        limitOffset = 5
    }
}

