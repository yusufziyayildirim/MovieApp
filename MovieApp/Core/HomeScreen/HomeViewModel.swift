//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Yusuf Ziya YILDIRIM on 7.05.2023.
//

import Foundation

protocol HomeViewModelProtocol {
    var delegate: HomeViewModelDelegate? { get set }
    
    func viewDidLoad()
    func getMovies()
}


final class HomeViewModel {
    
    weak var delegate: HomeViewModelDelegate?
    private let service = MovieService()
    var movies: [MovieResult] = []
    private var page: Int = 1
}


extension HomeViewModel: HomeViewModelProtocol{
    func viewDidLoad() {
        delegate?.configureVC()
        delegate?.configureCollectionView()
        getMovies()
    }
    
    func getMovies() {
        service.getMovies(page: page) { [weak self] returnedMovies in
            guard let self = self else { return }
            guard let returnedMovies = returnedMovies else { return }
            
            self.movies.append(contentsOf: returnedMovies.results ?? [])
            self.page += 1
            print(self.movies.count)
        }
    }
}
