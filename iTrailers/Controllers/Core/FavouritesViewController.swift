//
//  FavouritesViewController.swift
//  iTrailers
//
//  Created by Wilson Mungai on 2023-03-07.
//

import UIKit
// responsible for show favourites items stored in coredata
class FavouritesViewController: UIViewController {
    // database entity instance
    private var poster = [PosterItem]()
    // MARK: - UI Elements
    // table view
    let downloadTabelView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(PosterTableViewCell.self, forCellReuseIdentifier: PosterTableViewCell.cellIdentifier)
        tableView.separatorColor = UIColor.clear
        tableView.isHidden = true
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    

    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add subview
        view.addSubview(downloadTabelView)
        
        // table view setup
        tabelViewSetup()
        
        // API Caller
        fetchFavourites()
        
        // notify item has been added to database
        NotificationCenter.default.addObserver(forName: NSNotification.Name("downloaded"), object: nil, queue: nil) { _ in
            self.fetchFavourites()
        }
        
        view.backgroundColor = .systemBackground
    }
    // layout subviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        downloadTabelView.frame = view.bounds
    }
    
    // MARK: - Private methods
    // table view setup
    private func tabelViewSetup() {
        downloadTabelView.delegate = self
        downloadTabelView.dataSource = self
        title = "Favourites"
        // title color
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemIndigo]
        
    }
    // fetch favourites
    private func fetchFavourites() {
        DataPersistenceManager.shared.fetchSavedData { [weak self] result in
            switch result {
            case .success(let posters):
                self?.poster = posters
                DispatchQueue.main.async {
                    self?.downloadTabelView.reloadData()
                    self?.downloadTabelView.isHidden = false
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}


// MARK: - Table view extension
extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    // number of items saved
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return poster.count
    }
    // cell data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PosterTableViewCell.cellIdentifier, for: indexPath) as? PosterTableViewCell else {return UITableViewCell()}
        let poster = poster[indexPath.row]
        let imagePoster = poster.posterPath ?? ""
        let posterName = poster.title ?? poster.originalTitle ?? poster.name ?? poster.originalName ?? ""
        let posterRating = poster.voteAverage
        let posterReleaseDate = poster.releaseDate ?? poster.firstAirDate ?? ""
        cell.configure(with: DiscoverViewModel(posterImageUrl: imagePoster,
                                               posterName: posterName,
                                               posterRating: posterRating,
                                               releasedDate: posterReleaseDate))
        cell.selectionStyle = .none
        return cell
    }
 
    // row height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 330
    }
    
    // tells the delegate when the user scrolls
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // offset of the top inset of the screen
        let defaultOffSet = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffSet
        // when the user scrolls the naviagtion bar moves up
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
    // cell edit controll
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            // delete item
            DataPersistenceManager.shared.deleteData(model: poster[indexPath.row]) { [weak self] result in
                switch result {
                case .success():
                    print("Deleted fromt the database")
                case .failure(let error):
                    print(error.localizedDescription)
                }
                // remove the deleted item
                self?.poster.remove(at: indexPath.row)
                // delete the row
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        default:
            break;
        }
    }
    
    // functionality when cell is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let poster = poster[indexPath.row]
        let posterTitle = poster.title ?? poster.originalTitle ?? poster.name ?? poster.originalName ?? ""
        NetworkService.shared.getTrailer(with: posterTitle) { [weak self] result in
            switch result {
            case .success(let videoElement):
                // get the selected movie rating
                let rating = self?.poster[indexPath.row].voteAverage ?? 0
                // get the selected movie name
                let movieName = self?.poster[indexPath.row].title ?? self?.poster[indexPath.row].originalTitle ?? self?.poster[indexPath.row].name ?? self?.poster[indexPath.row].originalName ?? ""
                // get the selected movie released date
                let releaseDate = self?.poster[indexPath.row].releaseDate ?? self?.poster[indexPath.row].firstAirDate ?? ""
                // get the selected movie poster
                let moviePoster = self?.poster[indexPath.row].posterPath ?? ""
                // get the selected movie overview
                let overview = self?.poster[indexPath.row].overview ?? ""
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
}
