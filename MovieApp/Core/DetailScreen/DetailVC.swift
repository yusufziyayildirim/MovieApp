//
//  DetailVC.swift
//  MovieApp
//
//  Created by Yusuf Ziya YILDIRIM on 9.05.2023.
//

import UIKit

protocol DetailViewModelDelegate: AnyObject {
    
    func configureVC()
}

final class DetailVC: UIViewController {
    
    private let movie: MovieResult
    private let viewModel = DetailViewModel()
    
    init(movie: MovieResult) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.viewDidLoad()
    }
}

extension DetailVC: DetailViewModelDelegate{
    func configureVC() {
        view.backgroundColor = .systemRed
    }
}
