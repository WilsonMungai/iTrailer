//
//  DownloadViewController.swift
//  iTrailers
//
//  Created by Wilson Mungai on 2023-03-07.
//

import UIKit

class DownloadViewController: UIViewController {
    
    private var poster = [PosterItem]()
    
    let downloadTabelView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(PosterTableViewCell.self, forCellReuseIdentifier: PosterTableViewCell.cellIdentifier)
        tableView.separatorColor = UIColor.clear
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(downloadTabelView)
        tabelViewSetup()
        title = "Favourite"
        view.backgroundColor = .systemBackground
        fetchFavourites()
        NotificationCenter.default.addObserver(forName: NSNotification.Name("downloaded"), object: nil, queue: nil) { _ in
            self.fetchFavourites()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        downloadTabelView.frame = view.bounds
    }
    
    private func tabelViewSetup() {
        downloadTabelView.delegate = self
        downloadTabelView.dataSource = self
    }
    
    private func fetchFavourites() {
        print("here")
        DataPersistenceManager.shared.fetchSavedData { [weak self] result in
            switch result {
            case .success(let posters):
                self?.poster = posters
                DispatchQueue.main.async {
                    self?.downloadTabelView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}


// MARK: - Table view extension
extension DownloadViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return poster.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PosterTableViewCell.cellIdentifier, for: indexPath) as? PosterTableViewCell else {return UITableViewCell()}
        let poster = poster[indexPath.row]
        let imagePoster = poster.posterPath ?? ""
        let posterName = poster.title ?? poster.originalTitle ?? ""
        let posterRating = poster.voteAverage
        let posterReleaseDate = poster.releaseDate ?? ""
        cell.configure(with: DiscoverViewModel(posterImageUrl: imagePoster,
                                               posterName: posterName,
                                               posterRating: posterRating,
                                               releasedDate: posterReleaseDate))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    // tells the delegate when the user scrolls
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // offset of the top inset of the screen
        let defaultOffSet = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffSet
        // when the user scrolls the naviagtion bar moves up
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            
            DataPersistenceManager.shared.deleteData(model: poster[indexPath.row]) { [weak self] result in
                switch result {
                case .success():
                    print("Deleted fromt the database")
                case .failure(let error):
                    print(error.localizedDescription)
                }
                self?.poster.remove(at: indexPath.row)
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
        let posterTitle = poster.title ?? poster.originalTitle ?? ""
        NetworkService.shared.getTrailer(with: posterTitle) { [weak self] result in
            switch result {
            case .success(let videoElement):
                // get the selected movie rating
                let rating = self?.poster[indexPath.row].voteAverage ?? 0
                // get the selected movie name
                let movieName = self?.poster[indexPath.row].title ?? self?.poster[indexPath.row].originalTitle ?? ""
                // get the selected movie released date
                let releaseDate = self?.poster[indexPath.row].releaseDate ?? ""
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
