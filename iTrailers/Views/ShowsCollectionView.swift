//
//  ShowsCollectionView.swift
//  iTrailers
//
//  Created by Wilson Mungai on 2023-03-21.
//

import Foundation
import UIKit

class ShowsCollectionView: UITableViewCell {
    private var trendingTv: [TrendingTv] = [TrendingTv]()
    
    // collection view
    let trendingTvCollectionView: UICollectionView = {
        // setup collection view layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 200, height: 300)
        // create collection view with the layout specified
        let collectionView = UICollectionView(frame:.zero, collectionViewLayout: layout)
        // register cell
        collectionView.register(PosterCollectionViewCell.self,
                                forCellWithReuseIdentifier: PosterCollectionViewCell.cellIdentifier)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews(trendingTvCollectionView)
        // collection view setup
        trendingTvCollectionViewSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func trendingTvCollectionViewSetup() {
//        trendingTvCollectionView.delegate = self
//        trendingTvCollectionView.dataSource = self
    }
    
    // Set up frame
    override func layoutSubviews() {
        super.layoutSubviews()
        trendingTvCollectionView.frame = contentView.bounds
    }
    
    public func configure(with trending: [TrendingTv]) {
        trendingTv = trending
        DispatchQueue.main.async { [weak self] in
            self?.trendingTvCollectionView.reloadData()
        }
    }
}
