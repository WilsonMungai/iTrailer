//
//  PosterTableViewCell.swift
//  iTrailers
//
//  Created by Wilson Mungai on 2023-03-17.
//

import UIKit

// responsible for showing 
class PosterTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "PosterTableViewCell"
    
    // MARK: - UI components
    // poster image
    private let posterImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "header")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 20
        return image
    }()
    
    // poster 1image container view
    private let imageContainer: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.clipsToBounds = false
        containerView.layer.cornerRadius = 5
        containerView.layer.shadowColor = UIColor.darkGray.cgColor
        containerView.layer.shadowOffset = CGSize(width: -3.0, height: 3.0)
//        containerView.layer.shadowOffset = CGSize.zero
        containerView.layer.shadowRadius = 5
        containerView.layer.shadowOpacity = 0.9
//        containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: 10).cgPath
        return containerView
    }()
    
    // poster label
    private let posterLabel: UILabel = {
        let label = UILabel()
        label.text = "Movie Name"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = UIFont(name:"Arial Rounded MT Bold", size: 24)
        return label
    }()
    
    // poster rating
    private let posterRating: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "7.5"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    // star rating image
    private let imageRating: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "star.fill")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.tintColor = UIColor(named: "gold")
        return image
    }()
    
    // release date
    private let posterReleaseDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "March,26,2023"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    


    // MARK: - initializer
    // initialize table view cell
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        imageContainer.addSubview(posterImage)
        contentView.addSubviews(imageContainer,
                                posterLabel,
                                posterRating,
                                imageRating,
                                posterReleaseDate)
        addConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Private methods
    // layout constraints
    private func addConstraint() {
        NSLayoutConstraint.activate([
            // poster image constraints
            posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            posterImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            posterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            posterImage.heightAnchor.constraint(equalToConstant: 200),
            posterImage.widthAnchor.constraint(equalToConstant: 200),
            
            // poster label constraints
            posterLabel.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 8),
            posterLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            posterLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
//            posterLabel.heightAnchor.constraint(equalToConstant: 50),
            
            imageRating.leadingAnchor.constraint(equalTo: posterLabel.leadingAnchor),
            imageRating.topAnchor.constraint(equalTo: posterLabel.bottomAnchor, constant: 8),
            imageRating.heightAnchor.constraint(equalToConstant: 50),
            imageRating.trailingAnchor.constraint(equalTo: posterRating.leadingAnchor),
            
//            posterRating.leadingAnchor.constraint(equalTo: posterLabel.leadingAnchor),
            posterRating.centerYAnchor.constraint(equalTo: imageRating.centerYAnchor),
            posterRating.leadingAnchor.constraint(equalTo: imageRating.trailingAnchor, constant: 8),
            posterRating.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
//            posterRating.heightAnchor.constraint(equalToConstant: 50),
            
            posterReleaseDate.leadingAnchor.constraint(equalTo: posterLabel.leadingAnchor),
            posterReleaseDate.topAnchor.constraint(equalTo: imageRating.bottomAnchor, constant: 8),
            posterReleaseDate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
//            posterReleaseDate.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - Public methods
    public func configure(with viewModel: DiscoverViewModel) {
        // hook up the poster label to the view model
        posterLabel.text = viewModel.posterName
        // hook up the poster rating to the view model
        posterRating.text = String(format: "%.1f", viewModel.posterRating)
        // hook up the poster release date to the view model
        posterReleaseDate.text = viewModel.releasedDate
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(viewModel.posterImageUrl)") else { return }
        posterImage.sd_setImage(with: url, completed: nil)
    }
    
}


