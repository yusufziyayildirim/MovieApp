//
//  HomeVC.swift
//  MovieApp
//
//  Created by Yusuf Ziya YILDIRIM on 7.05.2023.
//

import UIKit

protocol HomeViewModelDelegate: AnyObject{
    func configureVC()
    func configureCollectionView()
    func reloadCollectionView()
    func navigateToDetailScreen(movie: MovieResult)
}

final class HomeVC: UIViewController {
    
    private let viewModel = HomeViewModel()
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.viewDidLoad()
    }
    
}

extension HomeVC: HomeViewModelDelegate{
    func configureVC() {
        view.backgroundColor = .systemGray
        title = "Popular Movies"
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createHomeFlowLayout())
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseID)
        
        collectionView.pinToEdgesOf(view: view)
    }
    
    func reloadCollectionView() {
        collectionView.reloadOnMainThread()
    }
    
    func navigateToDetailScreen(movie: MovieResult) {
        DispatchQueue.main.async {
            let detailScreen = DetailVC(movie: movie)
            self.navigationController?.pushViewController(detailScreen, animated: true)
        }
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseID, for: indexPath) as! MovieCell
        
        cell.setCell(movie: viewModel.movies[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.getDetail(movieResult: viewModel.movies[indexPath.item])
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY >= contentHeight - (3 * height) && viewModel.shouldDownloadMore {
            viewModel.getMovies()
        }
    }
    
}
