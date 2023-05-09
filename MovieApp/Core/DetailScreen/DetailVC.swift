//
//  DetailVC.swift
//  MovieApp
//
//  Created by Yusuf Ziya YILDIRIM on 9.05.2023.
//

import UIKit

protocol DetailViewModelDelegate: AnyObject {
    func configureVC()
    func configurePosterImageView()
    func downloadPosterImage()
    func configureTitleLabel()
    func configureDateLabel()
    func configureVoteLabel()
    func configureOverviewLabel()
}

final class DetailVC: UIViewController {
    
    private let movie: MovieResult
    private let viewModel = DetailViewModel()
    
    private let padding: CGFloat = 16
    
    
    
    private var posterImageView: PosterImageView!
    private var titleLabel: UILabel!
    private var dateLabel: UILabel!
    private var starImage: UIImageView!
    private var voteAverageLabel: UILabel!
    private var voteCountLabel: UILabel!
    private var overviewLabel: UILabel!
    
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
        view.backgroundColor = .systemBackground
        let scroolView = UIScrollView()
        view.addSubview(scroolView)
        scroolView.translatesAutoresizingMaskIntoConstraints = false
        scroolView.pinToEdgesOf(view: view)
    }
    
    func configurePosterImageView() {
        posterImageView = PosterImageView(frame: .zero)
        view.addSubview(posterImageView)
        
        posterImageView.layer.cornerRadius = 16
        posterImageView.clipsToBounds = true
        
        let posterWidth = CGFloat.deviceWidth * 0.4
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            posterImageView.widthAnchor.constraint(equalToConstant: posterWidth),
            posterImageView.heightAnchor.constraint(equalToConstant: posterWidth * 1.5)
        ])
    }
    
    func downloadPosterImage() {
        posterImageView.downloadImage(movie: movie)
    }
    
    func configureTitleLabel() {
        titleLabel = UILabel(frame: .zero)
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = movie.title
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
    }
    
    func configureDateLabel() {
        dateLabel = UILabel(frame: .zero)
        view.addSubview(dateLabel)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dateLabel.text = movie.releaseDate
        dateLabel.font = .systemFont(ofSize: 18)
        dateLabel.textColor = .secondaryLabel
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 1.2 * padding),
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
    }
    
    func configureVoteLabel() {
        starImage = UIImageView(image: UIImage(systemName: "star.fill"))
        voteCountLabel = UILabel(frame: .zero)
        voteAverageLabel = UILabel(frame: .zero)
        
        view.addSubview(starImage)
        view.addSubview(voteCountLabel)
        view.addSubview(voteAverageLabel)
        
        starImage.translatesAutoresizingMaskIntoConstraints = false
        voteCountLabel.translatesAutoresizingMaskIntoConstraints = false
        voteAverageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        if let voteAverage = movie.voteAverage, let voteCount = movie.voteCount  {
            voteAverageLabel.text = "\(voteAverage) / 10"
            voteCountLabel.text = "\(voteCount)K"
        } else {
            voteAverageLabel.text = "N/A"
        }
        
        starImage.tintColor = .systemYellow
        
        voteAverageLabel.font = .systemFont(ofSize: 18)
        voteAverageLabel.textColor = .systemYellow
        
        voteCountLabel.font = .systemFont(ofSize: 14)
        voteCountLabel.textColor = .secondaryLabel
        
        NSLayoutConstraint.activate([
            starImage.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: padding),
            starImage.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            
            voteAverageLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: padding),
            voteAverageLabel.leadingAnchor.constraint(equalTo: starImage.leadingAnchor, constant: 25),
            voteAverageLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            voteCountLabel.topAnchor.constraint(equalTo: voteAverageLabel.bottomAnchor),
            voteCountLabel.leadingAnchor.constraint(equalTo: voteAverageLabel.leadingAnchor),
            voteCountLabel.trailingAnchor.constraint(equalTo: voteAverageLabel.trailingAnchor)
        ])
    }
    
    func configureOverviewLabel() {
        overviewLabel = UILabel(frame: .zero)
        view.addSubview(overviewLabel)
        
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        
        overviewLabel.text = movie.overview
        overviewLabel.font = .systemFont(ofSize: 20)
        overviewLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            overviewLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 2 * padding),
            overviewLabel.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor),
            overviewLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
    }
}
