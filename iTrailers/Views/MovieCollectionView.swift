//
//  PosterCollectionViewCell.swift
//  iTrailers
//
//  Created by Wilson Mungai on 2023-03-17.
//

import UIKit

// Responsible for showing the video posters collection view
class MovieCollectionView: UITableViewCell {
    
    // cell identifier
    static let cellIdentifier = "PosterCollectionView"
    
    private var moviePoster: [Movie] = [Movie]()
    
    
    // MARK: - UI elements
    // collection view
    let movieCollectionView: UICollectionView = {
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
    
    
    // MARK: - Lifecycle methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews(movieCollectionView)
        
        // collection view setup
        movieCollectionViewSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    // Set up frame
    override func layoutSubviews() {
        super.layoutSubviews()
        movieCollectionView.frame = contentView.bounds
    }
    
    // MARK: - Private methods
    // collection view setup
    private func movieCollectionViewSetup() {
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
    }
    
    // MARK: - Pulic methods
    // configure
    public func configure(with movie: [Movie]) {
        moviePoster = movie
        DispatchQueue.main.async { [weak self] in
            self?.movieCollectionView.reloadData()
        }
    }
}

// MARK: - Xxtension
extension MovieCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviePoster.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.cellIdentifier, for: indexPath) as? PosterCollectionViewCell else {return UICollectionViewCell()}
        let posterTitle = moviePoster[indexPath.row].originalTitle ?? moviePoster[indexPath.row].title ?? ""
        guard let tendingPoster = moviePoster[indexPath.row].posterPath else { return UICollectionViewCell() }
        cell.configure(with: TrendingViewModel(trendingPosterUrl: tendingPoster, trendingPosterName: posterTitle))
        return cell
        
    }
}
