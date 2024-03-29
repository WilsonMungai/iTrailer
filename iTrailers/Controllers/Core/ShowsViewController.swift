//
//  TrendingViewController.swift
//  iTrailers
//
//  Created by Wilson Mungai on 2023-03-07.
//

import UIKit
// responsible for holding tv shows sections
class ShowsViewController: UIViewController {
    
    // titles of header sections
    private var sectionTitle: [String] = ["Trending", "Popular", "Top Rated", "Airing Today"]
    
    // object of TrendingTv model
    private var showPoster: [TrendingTv] = [TrendingTv]()
    
    // MARK: - UI component
    let trendingTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(ShowsCollectionView.self, forCellReuseIdentifier: ShowsCollectionView.cellIdentifier)
        tableView.separatorColor = UIColor.clear
        tableView.isHidden = true
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    // spinner
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(trendingTableView)
        view.addSubview(spinner)
        
        // start spinner
        spinner.startAnimating()
        
        // table view setup
        tabelViewSetup()
        
        // add constraints
        addConstraints()
        
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        trendingTableView.frame = view.bounds
    }
    
    // MARK: - Private methods
    private func tabelViewSetup() {
        trendingTableView.delegate = self
        trendingTableView.dataSource = self
        title = "Tv Shows"
        // title color
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemIndigo]
    }
    
    // setup constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

// MARK: - Table view extension
extension ShowsViewController: UITableViewDelegate, UITableViewDataSource {
    
    // number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // number of sections in the table views
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShowsCollectionView.cellIdentifier, for: indexPath) as? ShowsCollectionView else { return UITableViewCell() }
        
        // setup delegate to the cell to be notified when a movie has been selected
        cell.delegate = self
        
        switch indexPath.section {
            // trending tv shows
        case TableSections.Trending.rawValue:
            NetworkService.shared.getTrendingTv { [weak self] result in
                switch result {
                case .success(let tv):
                    cell.configure(with: tv)
                    DispatchQueue.main.async {
                        self?.trendingTableView.isHidden = false
                        self?.spinner.stopAnimating()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            // popular tv shows
        case TableSections.Popular.rawValue:
            NetworkService.shared.getPopularTv { result in
                switch result {
                case .success(let tv):
                    cell.configure(with: tv)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            // top rated shows
        case TableSections.NowPlaying.rawValue:
            NetworkService.shared.getTopRatedTv { result in
                switch result {
                case .success(let tv):
                    cell.configure(with: tv)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            // now playing tv shows
        case TableSections.TopRated.rawValue:
            NetworkService.shared.getAiringTodayTv { result in
                switch result {
                case .success(let tv):
                    cell.configure(with: tv)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
//        default: UITableViewCell()
        default: break
        }
        return cell
    }
    
    // height of row holding the collection view
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 330
    }
    
    // title for each section
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

// did tap cell delegate
extension ShowsViewController: ShowsCollectionViewTableViewCellDelegate {
    func collectionViewTableViewCellDidTapCell(_ cell: ShowsCollectionView, viewModel: PreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = DetailPreviewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
