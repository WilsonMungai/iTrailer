//
//  DiscoverViewController.swift
//  iTrailers
//
//  Created by Wilson Mungai on 2023-03-07.
//

import UIKit
// reponsible for holding search bar and recommended movies
class DiscoverViewController: UIViewController {
  
    private var moviePoster = [Poster]()
    
    let searchTabelView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(PosterTableViewCell.self, forCellReuseIdentifier: PosterTableViewCell.cellIdentifier)
        tableView.separatorColor = UIColor.clear
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    // search bar controller
    private let searchController: UISearchController = {
        // Creates and returns a search controller with the specified view controller for displaying the results.
        let controller = UISearchController(searchResultsController: SearchResultViewController())
        // search bar
        controller.searchBar.placeholder = "Search for Movie or TV Show"
        // search bar style
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(searchTabelView)
        
        view.backgroundColor = .systemBackground
        
       
        // table view setup method
        tabelViewSetup()
        
        // search controller setup
        searchControllerSetup()
        
        // API Caller
        fetchDiscoverMovies()
    }
    // table view frame
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchTabelView.frame = view.bounds
    }
    
    // MARK: - Private methods
    // table view setup
    private func tabelViewSetup() {
        searchTabelView.delegate = self
        searchTabelView.dataSource = self
        
        title = "Discover"
        // title color
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemIndigo]
        
    }
    
    private func searchControllerSetup() {
        // integrate the search controller onto our naivagation stack
        navigationItem.searchController = searchController
        // update when search is updated
        searchController.searchResultsUpdater = self

    }
    
    // fetch the popular movies
    private func fetchDiscoverMovies() {
        NetworkService.shared.getPopularMovies { [weak self] result in
            switch result {
            case .success(let movies):
                self?.moviePoster = movies
                DispatchQueue.main.async {
                    self?.searchTabelView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }


}

// MARK: - Table view extension
extension DiscoverViewController: UITableViewDelegate, UITableViewDataSource {
    // number of cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviePoster.count
    }
    // hook up cell to view model to display the data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PosterTableViewCell.cellIdentifier, for: indexPath) as? PosterTableViewCell else { return UITableViewCell() }
        let poster = moviePoster[indexPath.row]
        let imagePoster = poster.posterPath ?? ""
        let posterName = poster.originalTitle ?? poster.title ?? poster.name ?? poster.originalName ?? ""
        let posterRating = poster.voteAverage 
        let posterReleaseDate = poster.releaseDate ?? poster.firstAirDate ?? ""
        cell.configure(with: DiscoverViewModel(posterImageUrl: imagePoster,
                                                posterName: posterName,
                                                posterRating: posterRating,
                                                releasedDate: posterReleaseDate))
        cell.selectionStyle = .none
        return cell
    }
    // height of row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 330
    }
    // functionality when cell is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let poster = moviePoster[indexPath.row]
        let posterTitle = poster.originalTitle ?? poster.title ?? poster.name ?? poster.originalName ?? ""
        NetworkService.shared.getTrailer(with: posterTitle) { [weak self] result in
            switch result {
            case .success(let videoElement):
                // get the selected movie rating
                let rating = self?.moviePoster[indexPath.row].voteAverage ?? 0
                // get the selected movie name
                let movieName = self?.moviePoster[indexPath.row].title ?? self?.moviePoster[indexPath.row].originalTitle ?? self?.moviePoster[indexPath.row].name ?? self?.moviePoster[indexPath.row].originalName ?? ""
                // get the selected movie released date
                let releaseDate = self?.moviePoster[indexPath.row].releaseDate ?? self?.moviePoster[indexPath.row].firstAirDate ?? ""
                // get the selected movie poster
                let moviePoster = self?.moviePoster[indexPath.row].posterPath ?? ""
                // get the selected movie overview
                let overview = self?.moviePoster[indexPath.row].overview ?? ""
                // hook up view model to the selected data
                DispatchQueue.main.async {
                    let vc = DetailPreviewViewController()
                    vc.configure(with: PreviewViewModel(youtubeView: videoElement,
                                                        movieRating: rating,
                                                        movieName: movieName,
                                                        movieReleaseDate: releaseDate,
                                                        moviePoster: moviePoster,
                                                        movieOverView: overview))
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // tells the delegate when the user scrolls
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // offset of the top inset of the screen
        let defaultOffSet = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffSet
        // when the user scrolls the naviagtion bar moves up
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}
// MARK: - Search extension
extension DiscoverViewController: UISearchResultsUpdating, SearchResultsViewControllerDelegate {
    // navigate to detail screen when item is selected
    func searchResultsViewControllerDidTapItem(_ viewModel: PreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = DetailPreviewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    // update search results
    func updateSearchResults(for searchController: UISearchController) {
        // search bar item
        let searchBar = searchController.searchBar
        // user query
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 2,
              let resultController = searchController.searchResultsController as? SearchResultViewController else { return }
        // notify
        resultController.delegate = self
        // serch mover/show with the user query
        NetworkService.shared.searchMovie(with: query) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movie):
                    resultController.movie = movie
                    resultController.searchResultCollectionView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}



