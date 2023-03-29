//
//  DetailPreviewViewController.swift
//  iTrailers
//
//  Created by Wilson Mungai on 2023-03-22.
//

import UIKit
import WebKit

class DetailPreviewViewController: UIViewController {
    
    var moviePoster: Movie?
    
    // MARK: - UI Elements
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    // movie trailer web content
    private let trailerView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    // movie rating
    private let ratingLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "8.4/10"
        label.textColor = .secondaryLabel
        label.clipsToBounds = true
        // border
        label.layer.borderWidth = 0.5
        label.layer.borderColor = UIColor.darkGray.cgColor
        label.layer.masksToBounds = true
        label.paddingLeft = 5
        label.paddingRight = 5
        label.paddingTop = 5
        label.paddingBottom = 5
        label.layer.cornerRadius = 8
        label.numberOfLines = 0
        return label
    }()
    
    private let movieImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "header")
        image.clipsToBounds = true
        image.layer.cornerRadius = 20
        image.layer.masksToBounds = true
        return image
    }()
    
    // movie name
    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "John Wick"
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    // release date
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "Release: 31 August 2022"
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()
    
    // release date
    private let movieLanguageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = "Language: En"
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()
    
    // movie over view
    private let movieOverviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "This movie was produced in 2023 and is expected to be one of the best movies ou here. This movie was produced in 2023 and is expected to be one of the best movies ou here."
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()
    
    private let addToFavourite: UIButton = {
        var filled = UIButton.Configuration.plain()
        filled.title = "Download"
        filled.buttonSize = .large
        filled.subtitle = ""
        filled.image = UIImage(systemName: "arrow.down.square")
        filled.imagePlacement = .trailing
        filled.imagePadding = 5
        
        let button = UIButton(configuration: filled, primaryAction: nil)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .darkGray
        return button
    }()

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // add subviews
        view.addSubviews(trailerView,
                         ratingLabel,
                         addToFavourite,
                         movieImage,
                         movieNameLabel,
                         releaseDateLabel,
                         movieLanguageLabel,
                         movieOverviewLabel)
        // add constraints
        addConstraints()
        addToFavouriteButton()
    }
    
    // MARK: - Private Methods
    // download action
    private func addToFavouriteButton() {
        addToFavourite.addTarget(self, action: #selector(addToFavouriteTapped), for: .touchUpInside)
    }
    @objc private func addToFavouriteTapped() {
        guard let movie = moviePoster else { return }
        favourite(movie: movie)
    }
    private func favourite(movie: Movie) {
        print("here")
        DataPersistenceManager.shared.downloadPoster(model: movie) { result in
            switch result {
            case .success():
                print("saved to database")
            case .failure(let error):
                print(error)
            }
        }
    }
    // MARK: - Layout constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            // trailer web view constraints
            trailerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            trailerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            trailerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            trailerView.heightAnchor.constraint(equalToConstant: view.frame.size.height/4),
            
            // rating label constraints
            ratingLabel.topAnchor.constraint(equalTo: trailerView.bottomAnchor, constant: 8),
            ratingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            ratingLabel.heightAnchor.constraint(equalToConstant: 50),
            ratingLabel.widthAnchor.constraint(equalToConstant: 80),
            
            addToFavourite.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor),
            addToFavourite.centerYAnchor.constraint(equalTo: ratingLabel.centerYAnchor),
            addToFavourite.heightAnchor.constraint(equalToConstant: 50),
            addToFavourite.widthAnchor.constraint(equalToConstant: 150),
            
            
            // movie image constraints
            movieImage.topAnchor.constraint(equalTo: trailerView.bottomAnchor, constant: 8),
            movieImage.centerYAnchor.constraint(equalTo: movieLanguageLabel.centerYAnchor),
            movieImage.heightAnchor.constraint(equalToConstant: 200),
            movieImage.widthAnchor.constraint(equalToConstant: 150),
            movieImage.leadingAnchor.constraint(equalTo: releaseDateLabel.trailingAnchor),
            movieImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            // movie name label constraints
            movieNameLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor),
            movieNameLabel.leadingAnchor.constraint(equalTo: ratingLabel.leadingAnchor),
            movieNameLabel.trailingAnchor.constraint(equalTo: movieImage.leadingAnchor),
            movieNameLabel.heightAnchor.constraint(equalToConstant: 60),
            
            // movie language label constaints
            movieLanguageLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor),
            movieLanguageLabel.leadingAnchor.constraint(equalTo: ratingLabel.leadingAnchor),
            movieLanguageLabel.trailingAnchor.constraint(equalTo: movieNameLabel.trailingAnchor),
            
            // movie released date label constaints
            releaseDateLabel.topAnchor.constraint(equalTo: movieLanguageLabel.bottomAnchor),
            releaseDateLabel.leadingAnchor.constraint(equalTo: ratingLabel.leadingAnchor),
            releaseDateLabel.trailingAnchor.constraint(equalTo: movieNameLabel.trailingAnchor),
            
            // movie overview label constaints
            movieOverviewLabel.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 8),
            movieOverviewLabel.leadingAnchor.constraint(equalTo: ratingLabel.leadingAnchor),
            movieOverviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    // MARK: - Public method
    public func configure(with viewModel: PreviewViewModel) {
        // url to fetch the trailer
        guard let url = URL(string: "https://www.youtube.com/embed/\(viewModel.youtubeView.id.videoId)") else {
            return
        }
        // hook up the web view to the url
        trailerView.load(URLRequest(url: url))
        // rating label
        ratingLabel.text = String(format: "%.1f", viewModel.movieRating) + " / 10"
        // movie name label
        movieNameLabel.text = viewModel.movieName
        // move release date
        releaseDateLabel.text = "Released: " + viewModel.movieReleaseDate
        // movie overview
        movieOverviewLabel.text = viewModel.movieOverView
        // url to fetch poster image
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(viewModel.moviePoster)") else { return }
        // hook up image view to the url
        movieImage.sd_setImage(with: url, completed: nil)
    }
    
}
