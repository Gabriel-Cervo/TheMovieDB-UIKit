//
//  ImageViewExtension.swift
//  TheMovieDB
//
//  Created by Joao Gabriel Dourado Cervo on 30/06/21.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func imageFromServerURL(_ imageURL: String, placeHolder: UIImage?) {
        self.image = placeHolder
                    
        if let cachedImage = imageCache.object(forKey: NSString(string: imageURL)) {
            self.image = cachedImage
        }
     
        if let url = URL(string: imageURL) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                DispatchQueue.main.async {
                    if error != nil {
                        self.image = UIImage(named: "noImage")
                        return
                    }
                    
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            self.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
}
