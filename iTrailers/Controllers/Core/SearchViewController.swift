//
//  SearchViewController.swift
//  iTrailers
//
//  Created by Wilson Mungai on 2023-03-07.
//

import UIKit

class SearchViewController: UIViewController {
  
    private var moviePoster = [Movie]()
    
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

        title = "Discover"
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
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    // number of cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviePoster.count
    }
    // hook up cell to view model to display the data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PosterTableViewCell.cellIdentifier, for: indexPath) as? PosterTableViewCell else { return UITableViewCell() }
        let poster = moviePoster[indexPath.row]
        let imagePoster = poster.posterPath ?? ""
        let posterName = poster.title ?? poster.originalTitle ?? ""
        let posterRating = poster.voteAverage ?? 0.0
        let posterReleaseDate = poster.releaseDate ?? ""
        cell.configure(with: DiscoverViewModel(posterImageUrl: imagePoster,
                                                posterName: posterName,
                                                posterRating: posterRating,
                                                releasedDate: posterReleaseDate))
        return cell
    }
    // height of cells
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    // functionality when cell is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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

extension SearchViewController: UISearchResultsUpdating, SearchResultsViewControllerDelegate {
    func searchResultsViewControllerDidTapItem(_ viewModel: PreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = DetailPreviewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 2,
              let resultController = searchController.searchResultsController as? SearchResultViewController else { return }
        
        resultController.delegate = self
        
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



