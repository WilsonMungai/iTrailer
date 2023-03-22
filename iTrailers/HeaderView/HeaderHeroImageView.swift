//
//  HeaderHeroImageView.swift
//  iTrailers
//
//  Created by Wilson Mungai on 2023-03-16.
//

import UIKit

class HeaderHeroImageView: UIView {
    
    // MARK: - UI elements
    private let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "header")
        imageView.contentMode = .scaleAspectFill
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
}
