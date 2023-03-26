//
//  ShowsCollectionView.swift
//  iTrailers
//
//  Created by Wilson Mungai on 2023-03-21.
//

import Foundation
import UIKit

// protocol to keep track when a tv show is selected
protocol ShowsCollectionViewTableViewCellDelegate: AnyObject {
    func collectionViewTableViewCellDidTapCell(_ cell: ShowsCollectionView, viewModel: PreviewViewModel)
}


class ShowsCollectionView: UITableViewCell {
    
    // trending tv object
    private var showPoster: [TrendingTv] = [TrendingTv]()
    
    // instance of the delegate
    weak var delegate: ShowsCollectionViewTableViewCellDelegate?
    
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
        showPoster = trending
        DispatchQueue.main.async { [weak self] in
            self?.trendingTvCollectionView.reloadData()
        }
    }
}

extension ShowsCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    // number of shows returned per section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return showPoster.count
    }
    
    // data displayed in the cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.cellIdentifier, for: indexPath) as? PosterCollectionViewCell else { return UICollectionViewCell()}
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.cellIdentifier, for: indexPath)
        if let gridCell = cell as? PosterCollectionViewCell {
                    // TODO: configure cell
            let posterTitle = showPoster[indexPath.row].name ?? showPoster[indexPath.row].originalName ?? ""
            guard let posterImage = showPoster[indexPath.row].posterPath else { return UICollectionViewCell() }
            gridCell.configure(with: TrendingViewModel(trendingPosterUrl: posterImage, trendingPosterName: posterTitle))
                }
                return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // deselect selected item
        collectionView.deselectItem(at: indexPath, animated: true)
        let show = showPoster[indexPath.row]
        guard let showName = show.name ?? show.originalName else { return }
        NetworkService.shared.getTrailer(with: showName + " trailer") { [weak self] result in
            switch result {
                // incase of sucess display the show details
            case .success(let videoElement):
                guard let rating = self?.showPoster[indexPath.row].voteAverage else {return}
                guard let showName = self?.showPoster[indexPath.row].originalName ?? self?.showPoster[indexPath.row].name else {return}
                guard let releaseDate = self?.showPoster[indexPath.row].firstAirDate else {return}
                guard let poster = self?.showPoster[indexPath.row].posterPath else {return}
                guard let overview = self?.showPoster[indexPath.row].overview else {return}
                let viewModel = PreviewViewModel(youtubeView: videoElement,
                                                 movieRating: rating,
                                                 movieName: showName,
                                                 movieReleaseDate: releaseDate,
                                                 moviePoster: poster,
                                                 movieOverView: overview)
                // strong self
                guard let strongSelf = self else { return }
                // setup the delegate
                self?.delegate?.collectionViewTableViewCellDidTapCell(strongSelf, viewModel: viewModel)
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
}
