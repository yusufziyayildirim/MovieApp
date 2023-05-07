//
//  MovieService.swift
//  MovieApp
//
//  Created by Yusuf Ziya YILDIRIM on 7.05.2023.
//

import Foundation

class MovieService{
    
    func getMovies(page: Int, completion: @escaping ((Movie?, Error?) -> ())){
        
        NetworkManager.shared.request(type: Movie.self, url: APIURLs.movies(page: page), method: .get) { response in
            switch response {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
}
