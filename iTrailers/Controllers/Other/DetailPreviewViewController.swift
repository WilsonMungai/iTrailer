//
//  DetailPreviewViewController.swift
//  iTrailers
//
//  Created by Wilson Mungai on 2023-03-22.
//

import UIKit
import WebKit

class DetailPreviewViewController: UIViewController {
    
    // MARK: - UI Elements
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
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.text = "8.4/10"
        label.textColor = .secondaryLabel
        // border
        label.layer.borderWidth = 0.5
        label.layer.borderColor = UIColor.darkGray.cgColor
//        label.layer.masksToBounds = true
        label.paddingLeft = 5
        label.paddingRight = 5
        label.paddingTop = 5
        label.paddingBottom = 5
        label.layer.cornerRadius = 5
//        label.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
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
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "John Wick"
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    // release date
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "Release: 31 August 2022"
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()
    
    // release date
    private let movieLanguageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "Language: En"
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()
    
    // movie over view
    private let movieOverviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "This movie was produced in 2023 and is expected to be one of the best movies ou here. This movie was produced in 2023 and is expected to be one of the best movies ou here."
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // add subviews
        view.addSubviews(trailerView,
                         ratingLabel,
                         movieImage,
                         movieNameLabel,
                         releaseDateLabel,
                         movieLanguageLabel,
                         movieOverviewLabel)
        // add constraints
        addConstraints()
    }
    
    // MARK: - Private Methods
    // MARK: - Layout constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
//            trailerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            trailerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            trailerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            trailerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            trailerView.heightAnchor.constraint(equalToConstant: view.frame.size.height/4),
            
            ratingLabel.topAnchor.constraint(equalTo: trailerView.bottomAnchor, constant: 8),
            ratingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            ratingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            ratingLabel.heightAnchor.constraint(equalToConstant: 50),
            ratingLabel.widthAnchor.constraint(equalToConstant: 70),
            
            movieImage.topAnchor.constraint(equalTo: trailerView.bottomAnchor, constant: 8),
            movieImage.centerYAnchor.constraint(equalTo: movieLanguageLabel.centerYAnchor),
            movieImage.heightAnchor.constraint(equalToConstant: 200),
            movieImage.widthAnchor.constraint(equalToConstant: 150),
            movieImage.leadingAnchor.constraint(equalTo: releaseDateLabel.trailingAnchor),
            movieImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            movieNameLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor),
            movieNameLabel.leadingAnchor.constraint(equalTo: ratingLabel.leadingAnchor),
            movieNameLabel.trailingAnchor.constraint(equalTo: movieImage.leadingAnchor),
//            movieNameLabel.heightAnchor.constraint(equalToConstant: 50),
            
            movieLanguageLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor),
            movieLanguageLabel.leadingAnchor.constraint(equalTo: ratingLabel.leadingAnchor),
            movieLanguageLabel.trailingAnchor.constraint(equalTo: movieNameLabel.trailingAnchor),
            
            releaseDateLabel.topAnchor.constraint(equalTo: movieLanguageLabel.bottomAnchor),
            releaseDateLabel.leadingAnchor.constraint(equalTo: ratingLabel.leadingAnchor),
            releaseDateLabel.trailingAnchor.constraint(equalTo: movieNameLabel.trailingAnchor),
//            releaseDateLabel.heightAnchor.constraint(equalToConstant: 50),
            
           
            
            movieOverviewLabel.topAnchor.constraint(equalTo: movieImage.bottomAnchor),
            movieOverviewLabel.leadingAnchor.constraint(equalTo: ratingLabel.leadingAnchor),
            movieOverviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    // MARK: - Public method
    public func configure(with model: PreviewViewModel) {
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeView.id.videoId)") else {
            return
        }
        trailerView.load(URLRequest(url: url))
        ratingLabel.text = String(model.movieRating)
        movieNameLabel.text = model.movieName
        movieOverviewLabel.text = model.movieOverView
        releaseDateLabel.text = model.movieReleaseDate
        
    }
    
}
