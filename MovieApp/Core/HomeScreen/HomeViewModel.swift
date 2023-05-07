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
}


final class HomeViewModel {
    weak var delegate: HomeViewModelDelegate?
}


extension HomeViewModel: HomeViewModelProtocol{
    func viewDidLoad() {
        delegate?.configureVC()
    }
}
