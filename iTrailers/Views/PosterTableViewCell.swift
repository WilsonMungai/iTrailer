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
    private let posterImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "header")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.cornerRadius = 20
        return image
    }()
    
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
        contentView.addSubviews(posterImage,
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
            posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            posterImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            posterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            posterImage.heightAnchor.constraint(equalToConstant: 300),
            posterImage.widthAnchor.constraint(equalToConstant: 200),
            
            posterLabel.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 8),
            posterLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            posterLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            posterLabel.heightAnchor.constraint(equalToConstant: 50),
            
            playButton.trailingAnchor.constraint(equalTo: posterLabel.trailingAnchor),
            playButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
    
}
