//
//  HomeVC.swift
//  MovieApp
//
//  Created by Yusuf Ziya YILDIRIM on 7.05.2023.
//

import UIKit

protocol HomeViewModelDelegate: AnyObject{
    func configureVC()
}

final class HomeVC: UIViewController {
    
    private let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.viewDidLoad()
    }
    
}


extension HomeVC: HomeViewModelDelegate{
    func configureVC() {
        view.backgroundColor = .systemRed
    }
    
}
