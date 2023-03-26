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
        image.dropShadow()
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 20
        return image
    }()
    
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
        label.text = "This is a placeholder for poster name"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        return label
    }()
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = (UIImage(systemName: "play.circle",
                             withConfiguration: UIImage.SymbolConfiguration(pointSize: 40)))
        button.setImage(image , for: .normal)
        button.tintColor = .secondaryLabel
        return button
    }()

    // MARK: - initializer
    // initialize table view cell
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        imageContainer.addSubview(posterImage)
        contentView.addSubviews(imageContainer,
                                posterLabel,
                                playButton)
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
            
            playButton.trailingAnchor.constraint(equalTo: posterLabel.trailingAnchor),
            playButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
    
}


