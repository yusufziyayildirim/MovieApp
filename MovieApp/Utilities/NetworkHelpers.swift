//
//  NetworkHelpers.swift
//  MovieApp
//
//  Created by Yusuf Ziya YILDIRIM on 7.05.2023.
//

import Foundation


enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum APIURLs {
    static var apiKey = "e112ed72df8da5c3b38e4e6579896bc6&language"
    
    static func movies(page: Int) -> String {
        "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)6&language=en-US&page=\(page)"
    }
    
    static func imageURL(posterPath: String) -> String {
        "https://image.tmdb.org/t/p/w500\(posterPath)"
    }
    
    static func movieDetail(id: Int) -> String {
        "https://api.themoviedb.org/3/movie/\(id)?api_key=\(apiKey)&language=en-US"
    }
}
