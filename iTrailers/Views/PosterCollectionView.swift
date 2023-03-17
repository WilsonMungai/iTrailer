//
//  PosterCollectionViewCell.swift
//  iTrailers
//
//  Created by Wilson Mungai on 2023-03-17.
//

import UIKit

// Responsible for showing the video posters collection view
class PosterCollectionView: UITableViewCell {
    
    // cell identifier
    static let cellIdentifier = "PosterCollectionView"
    
    // MARK: - UI elements
    // collection view
    let collectionView: UICollectionView = {
        // setup collection view layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 200, height: 400)
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
        contentView.addSubview(collectionView)
        
        // collection view setup
        collectionViewSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    // Set up frame
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    // collection view setup
    private func collectionViewSetup() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - collection view setup
extension PosterCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.cellIdentifier, for: indexPath)
//        cell.backgroundColor = .systemGray
        return cell
    }
}
