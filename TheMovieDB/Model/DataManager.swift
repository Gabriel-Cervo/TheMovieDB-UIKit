//
//  DataManager.swift
//  TheMovieDB
//
//  Created by Joao Gabriel Dourado Cervo on 30/06/21.
//

import UIKit

struct DataManager {
    static var shared = DataManager()
        
    func getData(from url: String, startingItem: Int, maxNumberOfItens: Int, completionHandler: @escaping (_ movies: [Movie]) -> Void) -> Void {
        guard let url = URL(string: url) else { fatalError("Cannot load from url: \(url)") }
                
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            guard let decodedMovies: DataModel = try? decoder.decode(DataModel.self, from: data) else {
                print("Cannot convert to [Movie]")
                return
            }
            
            DispatchQueue.main.async {
                var movies: [Movie] = []

                for index in startingItem..<maxNumberOfItens {
                    movies.append(decodedMovies.results[index])
                }
                
                completionHandler(movies)
            }
        }
        task.resume()
    }
}
