//
//  PosterCollectionViewCell.swift
//  iTrailers
//
//  Created by Wilson Mungai on 2023-03-17.
//

import UIKit

// protocol to keep track when a movie is tapped
protocol MovieCollectionViewTableViewCellDelegate: AnyObject {
    func collectionViewTableViewCellDidTapCell(_ cell: MovieCollectionView, viewModel: PreviewViewModel)
}

// Responsible for showing the video posters collection view
class MovieCollectionView: UITableViewCell {
    
    // cell identifier
    static let cellIdentifier = "PosterCollectionView"
    
    weak var delegate: MovieCollectionViewTableViewCellDelegate?
    
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
    // function to configure the colletion view to the home view controller
    public func configure(with movie: [Movie]) {
        // hook uo the movie
        moviePoster = movie
        DispatchQueue.main.async { [weak self] in
            // reload the table view
            self?.movieCollectionView.reloadData()
        }
    }
    
    private func downloadTitleAt(indexPath: IndexPath) {
        DataPersistenceManager.shared.downloadPoster(model: moviePoster[indexPath.row]) { result in
            switch result {
            case .success():
//                NotificationCenter.default.post(name: NSNotification.Name("downloaded"), object: nil)
                print("downloaded to database")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        

    }
}

// MARK: - Xxtension
extension MovieCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviePoster.count
    }
    
    // functionality to show movie data in the collection view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.cellIdentifier, for: indexPath) as? PosterCollectionViewCell else {return UICollectionViewCell()}
        // get the movie name
        let movieTitle = moviePoster[indexPath.row].originalTitle ?? moviePoster[indexPath.row].title ?? ""
        // get the movie poster
        guard let moviePoster = moviePoster[indexPath.row].posterPath else { return UICollectionViewCell() }
        cell.configure(with: TrendingViewModel(trendingPosterUrl: moviePoster, trendingPosterName: movieTitle))
        return cell
    }
    
    // functionality when a movie is selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // deselect the item selected
        collectionView.deselectItem(at: indexPath, animated: true)
        let movie = moviePoster[indexPath.row]
        guard let movieName = movie.originalTitle ?? movie.title else { return }
        NetworkService.shared.getTrailer(with: movieName + " trailer") { [weak self] result in
            switch result {
                // show the movie details incase of success
            case .success(let videoElement):
                // get the selected movie rating
                let rating = self?.moviePoster[indexPath.row].voteAverage ?? 0
                // get the selected movie name
                let movieName = self?.moviePoster[indexPath.row].title ?? self?.moviePoster[indexPath.row].originalTitle ?? ""
                // get the selected movie released date
                let releaseDate = self?.moviePoster[indexPath.row].releaseDate ?? ""
                // get the selected movie poster
                let moviePoster = self?.moviePoster[indexPath.row].posterPath ?? ""
                // get the selected movie overview
                let overview = self?.moviePoster[indexPath.row].overview ?? ""
                // hook up view model to the selected data
                let viewModel = PreviewViewModel(youtubeView: videoElement,
                                                 movieRating: rating,
                                                 movieName: movieName,
                                                 movieReleaseDate: releaseDate,
                                                 moviePoster: moviePoster,
                                                 movieOverView: overview)
                // strong self
                guard let strongSelf = self else { return }
                // setup the delegate
                self?.delegate?.collectionViewTableViewCellDidTapCell(strongSelf, viewModel: viewModel)
                
                // print error incase of failure
            case .failure(let error):
                print(error)
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let config = UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil) {[weak self] _ in
                let downloadAction = UIAction(title: "Download", subtitle: nil, image: nil, identifier: nil, discoverabilityTitle: nil, state: .off) { _ in
                    self?.downloadTitleAt(indexPath: indexPath)
                }
                return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [downloadAction])
            }
        
        return config
    }
}
