//
//  ShowsCollectionView.swift
//  iTrailers
//
//  Created by Wilson Mungai on 2023-03-21.
//

import Foundation
import UIKit

class ShowsCollectionView: UITableViewCell {
    
    // trending tv object
    private var trendingTv: [TrendingTv] = [TrendingTv]()
    
    // cell idnetifier
    static let cellIdentifier = "ShowsCollectionView"
    
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
        trendingTvCollectionView.delegate = self
        trendingTvCollectionView.dataSource = self
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

extension ShowsCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    // number of shows returned per section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trendingTv.count
    }
    
    // data displayed in the cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.cellIdentifier, for: indexPath) as? PosterCollectionViewCell else { return UICollectionViewCell()}
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.cellIdentifier, for: indexPath)
        if let gridCell = cell as? PosterCollectionViewCell {
                    // TODO: configure cell
            let posterTitle = trendingTv[indexPath.row].name ?? trendingTv[indexPath.row].originalName ?? ""
            guard let posterImage = trendingTv[indexPath.row].posterPath else { return UICollectionViewCell() }
            gridCell.configure(with: TrendingViewModel(trendingPosterUrl: posterImage, trendingPosterName: posterTitle))
                }
                return cell
    }
}
