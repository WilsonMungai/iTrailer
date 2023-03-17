//
//  PosterCollectionViewCell.swift
//  iTrailers
//
//  Created by Wilson Mungai on 2023-03-17.
//

import UIKit

// Collection view cell , holds poster data
class PosterCollectionViewCell: UICollectionViewCell {
    
    // cell identifier
    static let cellIdentifier = "PosterCollectionViewCell"
    
    // MARK: - UI components
    // poster image view
    private let posterImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "header")
        return image
    }()
    
    private let posterLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Movie Name, Movie Name, Movie Name"
        label.numberOfLines = 0
        return label
    }()
    
    private let posterType: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Movie Name"
        label.numberOfLines = 0
        return label
    }()
    
    
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews(posterImage,
                                posterLabel)
        contentView.backgroundColor = .secondarySystemBackground
        setUpLayer()
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
        contentView.layer.cornerRadius = 10
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
            
            // poster name constraint
            posterLabel.topAnchor.constraint(equalTo: posterImage.bottomAnchor),
            posterLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            posterLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            posterLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            posterLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
