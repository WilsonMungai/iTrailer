//
//  PosterCollectionViewCell.swift
//  iTrailers
//
//  Created by Wilson Mungai on 2023-03-17.
//

import UIKit
import SDWebImage

// Collection view cell , holds poster data
class PosterCollectionViewCell: UICollectionViewCell {
    
    // cell identifier
    static let cellIdentifier = "PosterCollectionViewCell"
    
//    let viewModel: TrendingViewModel
    
    // MARK: - UI components
    // poster image view
    private let posterImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "header")
        return image
    }()
    // poster label
    private let posterLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Movie Name, Movie Name, Movie Name"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        // add subviews
        contentView.addSubviews(posterImage,posterLabel)
        
        // cell background color
        contentView.backgroundColor = .secondarySystemBackground
        
        // content view layer
        setUpLayer()
        
        // layout constraint
        addConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Private methods
    // content view setup
    private func setUpLayer() {
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowColor = UIColor.label.cgColor
        contentView.layer.shadowOffset = CGSize(width: -4, height: 4)
        contentView.layer.shadowOpacity = 0.2
    }
    
    // MARK: - Layout constraints
    private func addConstraint() {
        NSLayoutConstraint.activate([
            // poster image layout
            posterImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            posterImage.heightAnchor.constraint(equalToConstant: 200),
//            posterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            
            // poster name constraint
            posterLabel.topAnchor.constraint(equalTo: posterImage.bottomAnchor),
            posterLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            posterLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            posterLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            posterLabel.heightAnchor.constraint(equalToConstant: 35),
        ])
    }
    
    // MARK: - public configuration
    // configure view model to the cell
    public func configure(with viewModel: TrendingViewModel) {
        posterLabel.text = viewModel.trendingPosterName
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(viewModel.trendingPosterUrl)") else { return }
        posterImage.sd_setImage(with: url, completed: nil)
    }
}
