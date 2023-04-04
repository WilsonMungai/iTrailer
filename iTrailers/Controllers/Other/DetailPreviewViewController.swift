//
//  DetailPreviewViewController.swift
//  iTrailers
//
//  Created by Wilson Mungai on 2023-03-22.
//

import UIKit
import WebKit

// responsible for movie/show detail preview
class DetailPreviewViewController: UIViewController {
    
    //    var moviePoster: Movie?
    private var moviePoster: [Poster] = [Poster]()
    
    // MARK: - UI Elements
    // scroll view
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        //   scroll view bounds should be set to be bigger than the screen to give room for scrolling
        scrollView.alwaysBounceVertical = true
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
    
    // star rating image
    private let calendarImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "calendar")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.tintColor = UIColor.systemIndigo
        return image
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
    
    // add favourite button
    private let addToFavourite: UIButton = {
        var filled = UIButton.Configuration.plain()
        filled.title = "Favourite"
        filled.buttonSize = .large
        filled.subtitle = ""
        filled.image = UIImage(systemName: "heart")
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
        view.addSubview(scrollView)
        scrollView.addSubviews(trailerView,
                               ratingLabel,
                               addToFavourite,
                               movieImage,
                               movieNameLabel,
                               releaseDateLabel,
                               movieLanguageLabel,
                               movieOverviewLabel,
                               calendarImage)
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
    }
    // MARK: - Layout constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            // scroll view
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // trailer web view constraints
            trailerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            trailerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
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
            movieImage.widthAnchor.constraint(equalToConstant: view.frame.size.width/3),
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
            
            // movie released date label constaints,
            releaseDateLabel.centerYAnchor.constraint(equalTo: calendarImage.centerYAnchor),
            releaseDateLabel.leadingAnchor.constraint(equalTo: calendarImage.trailingAnchor, constant: 4),
            
            calendarImage.leadingAnchor.constraint(equalTo: ratingLabel.leadingAnchor, constant: -4),
            calendarImage.topAnchor.constraint(equalTo: movieLanguageLabel.bottomAnchor),
            
            // movie overview label constaints
            movieOverviewLabel.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 8),
            movieOverviewLabel.leadingAnchor.constraint(equalTo: ratingLabel.leadingAnchor),
            movieOverviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
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
        releaseDateLabel.text = viewModel.movieReleaseDate
        // movie overview
        movieOverviewLabel.text = viewModel.movieOverView
        // url to fetch poster image
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(viewModel.moviePoster)") else { return }
        // hook up image view to the url
        movieImage.sd_setImage(with: url, completed: nil)
    }
    
}
