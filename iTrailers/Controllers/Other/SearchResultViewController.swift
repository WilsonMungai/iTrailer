//
//  SearchViewController.swift
//  iTrailers
//
//  Created by Wilson Mungai on 2023-03-17.
//

import UIKit

// protocol to keep track when search item result is tapped
protocol SearchResultsViewControllerDelegate: AnyObject {
    func searchResultsViewControllerDidTapItem(_ viewModel: PreviewViewModel)
}

// responsible to show the search view controller
class SearchResultViewController: UIViewController {
    
    // delegate
    public weak var delegate: SearchResultsViewControllerDelegate?
    
//    var movie = [Movie]()
    var movie = [Poster]()
    
    // MARK: - UI Elements
    // search view controller
    public let searchResultCollectionView: UICollectionView = {
        // layout that arranges items in a grid view with optional header and footer for each section
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width/3 - 10, height: 200)
        // spacing between items in the row
        layout.minimumInteritemSpacing = 0
        
        // collection view
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PosterCollectionViewCell.self,
                                forCellWithReuseIdentifier: PosterCollectionViewCell.cellIdentifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(searchResultCollectionView)
        collectionViewSetup()
    }
    
    // collection view setup
    func collectionViewSetup() {
        searchResultCollectionView.delegate = self
        searchResultCollectionView.dataSource = self
    }
    
    // notify view subviews have been laid iut
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultCollectionView.frame = view.bounds
    }

}

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource  {
    // return number of items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movie.count
    }
    // display search items
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.cellIdentifier,
                                                            for: indexPath) as? PosterCollectionViewCell else { return UICollectionViewCell() }
        // hook up cell to the view model
        let poster = movie[indexPath.row]
        let posterTitle = poster.originalTitle ?? poster.title ?? poster.name ?? poster.originalName ?? ""
        let posterImage = poster.posterPath ?? ""
        cell.configure(with: TrendingViewModel(trendingPosterUrl: posterImage,
                                               trendingPosterName: posterTitle))
        return cell
    }
    // navigate to show movie details
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let poster = movie[indexPath.row]
        // get movie or poster title
        let posterTitle = poster.title ?? poster.originalTitle ?? poster.name ?? poster.originalName ?? ""
        // search with the provided title
        NetworkService.shared.getTrailer(with: posterTitle) { [weak self] result in
            switch result {
            case .success(let videoElement):
                // get the selected movie rating
                let rating = self?.movie[indexPath.row].voteAverage ?? 0
                // get the selected movie name
                let movieName = self?.movie[indexPath.row].title ?? self?.movie[indexPath.row].originalTitle ?? self?.movie[indexPath.row].name ?? self?.movie[indexPath.row].originalName ?? ""
                // get the selected movie released date
                let releaseDate = self?.movie[indexPath.row].releaseDate ?? self?.movie[indexPath.row].firstAirDate ?? ""
                // get the selected movie poster
                let moviePoster = self?.movie[indexPath.row].posterPath ?? ""
                // get the selected movie overview
                let overview = self?.movie[indexPath.row].overview ?? ""
                // hook up view model to the selected data
                self?.delegate?.searchResultsViewControllerDidTapItem(PreviewViewModel(
                    youtubeView: videoElement,
                    movieRating: rating,
                    movieName: movieName,
                    movieReleaseDate: releaseDate,
                    moviePoster: moviePoster,
                    movieOverView: overview))
            case.failure(let error):
                print(error)
            }
        }
    }
    
    
}
