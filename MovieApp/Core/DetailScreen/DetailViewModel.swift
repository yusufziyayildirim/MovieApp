//
//  DetailViewModel.swift
//  MovieApp
//
//  Created by Yusuf Ziya YILDIRIM on 9.05.2023.
//

import Foundation

protocol DetailViewModelProtocol {
    var delegate: DetailViewModelDelegate? { get set }
    
    func viewDidLoad()
}

final class DetailViewModel {
    weak var delegate: DetailViewModelDelegate?
}

extension DetailViewModel: DetailViewModelProtocol{
    func viewDidLoad() {
        delegate?.configureVC()
        delegate?.configurePosterImageView()
        delegate?.downloadPosterImage()
        delegate?.configureTitleLabel()
        delegate?.configureDateLabel()
        delegate?.configureVoteLabel()
        delegate?.configureOverviewLabel()
    }
}
