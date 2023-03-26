//
//  HeaderHeroImageView.swift
//  iTrailers
//
//  Created by Wilson Mungai on 2023-03-16.
//

import UIKit
import SDWebImage

class HeaderHeroImageView: UIView {
    
    // MARK: - UI elements
    // hero header image
    private let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "header")
        imageView.contentMode = .scaleToFill
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        return imageView
    }()

    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Lifecycle methdos
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
    
    // MARK: - Public methdos
    public func configure(with viewModel: TrendingViewModel) {
        // get the image url
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(viewModel.trendingPosterUrl)") else { return }
        // set the image with cache
        heroImageView.sd_setImage(with: url)
    }
}
