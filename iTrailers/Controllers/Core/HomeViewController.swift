//
//  HomeViewController.swift
//  iTrailers
//
//  Created by Wilson Mungai on 2023-03-07.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var headerView: HeaderHeroImageView?
    
    let sectionTitle: [String] = ["Trending Movies", "Popular", "Now Playing", "Top Rated", "Upcoming Movies"]
    
    //MARK: - UI elements
    private let homeTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MovieCollectionView.self,
                           forCellReuseIdentifier: MovieCollectionView.cellIdentifier)
        tableView.separatorColor = UIColor.clear
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()

    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(homeTableView)
        
        // table view setup
        tableViewSetup()
        
        view.backgroundColor = .systemBackground
        
//        NetworkService.shared.getTrendingTv { result in
//            switch result {
//            case .success(let success):
//                print(success)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeTableView.frame = view.bounds
    }
    
    // MARK: - Private methods
    // table view setup
    private func tableViewSetup() {
        
        homeTableView.delegate = self
        homeTableView.dataSource = self
        // ignore safe area
        homeTableView.contentInsetAdjustmentBehavior = .never
        // header image
        headerView = HeaderHeroImageView(frame: CGRect(x: 0,
                                                       y: 0,
                                                       width: view.bounds.width,
                                                       height: view.bounds.height/2))
        // header view
        homeTableView.tableHeaderView = headerView
        
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
        return sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCollectionView.cellIdentifier, for: indexPath) as? MovieCollectionView else { return UITableViewCell() }
        
        switch indexPath.section {
            
        case TableSections.Trending.rawValue:
            NetworkService.shared.getTrendingMovie { result in
                switch result {
                case .success(let movie):
                    cell.configure(with: movie)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case TableSections.Popular.rawValue:
            NetworkService.shared.getPopularMovies {  result in
                switch result {
                case .success(let movie):
                    cell.configure(with: movie)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case TableSections.NowPlaying.rawValue:
            NetworkService.shared.getNowPlayingMovies { result in
                switch result {
                case .success(let movie):
                    cell.configure(with: movie)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case TableSections.Upcoming.rawValue:
            NetworkService.shared.getUpcomingMovies { result in
                switch result {
                case .success(let movie):
                    cell.configure(with: movie)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case TableSections.TopRated.rawValue:
            NetworkService.shared.getTopRatedMovies { result in
                switch result {
                case .success(let movie):
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
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
