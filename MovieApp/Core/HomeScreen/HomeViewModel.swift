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
    private var page: Int = 499
    var shouldDownloadMore: Bool = true
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
            
            /*
             It should be 'self.page >= returnedMovies.totalPages' but TMDB API does not allow requests to pages beyond 500. This may be due to the fact that we are using the free version of the API."
             */
            if self.page >= 500 {
                shouldDownloadMore = false
            }
            
            self.page += 1
            self.delegate?.reloadCollectionView()
        }
    }
    
    func getDetail(movieResult: MovieResult) {
        self.delegate?.navigateToDetailScreen(movie: movieResult)
    }
}
