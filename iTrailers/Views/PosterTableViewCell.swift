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
        
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        outerView.clipsToBounds = false
        outerView.layer.shadowColor = UIColor.black.cgColor
        outerView.layer.shadowOpacity = 1
        outerView.layer.shadowOffset = CGSize.zero
        outerView.layer.shadowRadius = 10
        outerView.layer.shadowPath = UIBezierPath(roundedRect: outerView.bounds, cornerRadius: 10).cgPath
        
        
        let image = UIImageView(frame: outerView.bounds)
        image.image = UIImage(named: "header")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
//        image.layer.cornerRadius = 10
//        image.layer.shadowColor = UIColor.label.cgColor
//        image.layer.shadowOffset = CGSize(width: -4, height: 4)
//        image.layer.shadowOpacity = 1
        outerView.addSubview(image)
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
    
    
    
    private func imageOuterView() {
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        outerView.clipsToBounds = false
        outerView.layer.shadowColor = UIColor.black.cgColor
        outerView.layer.shadowOpacity = 1
        outerView.layer.shadowOffset = CGSize.zero
        outerView.layer.shadowRadius = 10
        outerView.layer.shadowPath = UIBezierPath(roundedRect: outerView.bounds, cornerRadius: 10).cgPath
        outerView.addSubview(posterImage)
    }
    
    
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
