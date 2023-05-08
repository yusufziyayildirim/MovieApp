//
//  PosterImageView.swift
//  MovieApp
//
//  Created by Yusuf Ziya YILDIRIM on 8.05.2023.
//

import UIKit

class PosterImageView: UIImageView {
    
    private var dataTask: URLSessionDataTask?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func downloadImage(movie: MovieResult) {
        dataTask = NetworkManager.shared.request(type: Data.self, url: APIURLs.imageURL(posterPath: movie.posterPath ?? ""), method: .get) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                DispatchQueue.main.async { self.image = UIImage(data: data) }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func cancelDownloading() {
        dataTask?.cancel()
        dataTask = nil
    }
    
}
