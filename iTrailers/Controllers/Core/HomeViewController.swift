//
//  HomeViewController.swift
//  iTrailers
//
//  Created by Wilson Mungai on 2023-03-07.
//

import UIKit
// responsible for holding movies sections
class HomeViewController: UIViewController {

    // list of section titles
    let sectionTitle: [String] = ["Trending", "Popular", "Now Playing", "Top Rated", "Upcoming"]
    
    // HeaderHeroImageView instance
    private var headerView: HeaderHeroImageView?
    
    // Movie model
    private var randomHeaderImage: Poster?
    
    //MARK: - UI elements
    // movies table view
    private let homeTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(MovieCollectionView.self,
                           forCellReuseIdentifier: MovieCollectionView.cellIdentifier)
        tableView.separatorColor = UIColor.clear
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()

    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add table view as subview
        view.addSubview(homeTableView)
        
        // table view setup
        tableViewSetup()
        
        // view background color
        view.backgroundColor = .systemBackground

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // layout the table view frame
        homeTableView.frame = view.bounds
    }
    // MARK: - Private methods
    // table view setup
    private func tableViewSetup() {
        
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        title = "Movies"
        
        // title color
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemIndigo]
    }
}

// MARK: - Table view extensions
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    // number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // number of sections in the table views
    func numberOfSections(in tableView: UITableView) -> Int {
        // return count according to section titles we have
        return sectionTitle.count
    }
    // data to be return in each table row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCollectionView.cellIdentifier, for: indexPath) as? MovieCollectionView else { return UITableViewCell() }
        
        // setup delegate to the cell to be notified when a movie has been selected
        cell.delegate = self
        
        // switch on the sections to return the appropriate data
        switch indexPath.section {
            // trending movie section
        case TableSections.Trending.rawValue:
            // fetch the trending movies
            NetworkService.shared.getTrendingMovie { result in
                switch result {
                case .success(let movie):
                    // when we get the trending movies we configure it to the cell
                    cell.configure(with: movie)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            // popular movies section
        case TableSections.Popular.rawValue:
            NetworkService.shared.getPopularMovies {  result in
                switch result {
                case .success(let movie):
                    // when we get the popular movies we configure them to the cell
                    cell.configure(with: movie)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case TableSections.NowPlaying.rawValue:
            NetworkService.shared.getNowPlayingMovies { result in
                switch result {
                case .success(let movie):
                    // when we get the now playing movies we configure them to the cell
                    cell.configure(with: movie)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            // top rated movies section
        case TableSections.TopRated.rawValue:
            // fetch the top rated movies
            NetworkService.shared.getTopRatedMovies { result in
                switch result {
                case .success(let movie):
                    // when we get the top rated movies we configure them to the cell
                    cell.configure(with: movie)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
            // upcoming movies section
        case TableSections.Upcoming.rawValue:
            // fetch the upcoming movies
            NetworkService.shared.getUpcomingMovies { result in
                switch result {
                case .success(let movie):
                    // when we get the now upcoming movies we configure them to the cell
                    cell.configure(with: movie)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        default: return UITableViewCell()
        }
        return cell
    }
    
    // height of row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 330
    }
    
    // title for the sextions
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    // height of header section
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    // header title setup
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        tableView.backgroundColor = .clear
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        header.textLabel?.text = header.textLabel?.text?.capitalized
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20,
                                         y: header.bounds.origin.y,
                                         width: header.bounds.width,
                                         height: header.bounds.height)
        header.textLabel?.textColor = .label
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

// conform to the collection view delegate so as to get notified when a movie is selected and navigate to the movie detail view
extension HomeViewController: MovieCollectionViewTableViewCellDelegate {
    // conform to the delegate function
    func collectionViewTableViewCellDidTapCell(_ cell: MovieCollectionView, viewModel: PreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = DetailPreviewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
