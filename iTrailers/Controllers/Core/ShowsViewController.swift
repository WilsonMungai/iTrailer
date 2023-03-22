//
//  TrendingViewController.swift
//  iTrailers
//
//  Created by Wilson Mungai on 2023-03-07.
//

import UIKit

class ShowsViewController: UIViewController {
    
    // titles of header sections
    private var sectionTitle: [String] = ["Trending Tv", "Popular Tv", "Airing Today", "Top Rated"]
    
    // object of TrendingTv model
    private var showPoster: [TrendingTv] = [TrendingTv]()
    
    // MARK: - UI component
    let trendingTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(ShowsCollectionView.self, forCellReuseIdentifier: ShowsCollectionView.cellIdentifier)
        tableView.separatorColor = UIColor.clear
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(trendingTableView)
        title = "Trending"
        view.backgroundColor = .systemBackground
        tabelViewSetup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        trendingTableView.frame = view.bounds
    }
    
    // MARK: - Private methods
    private func tabelViewSetup() {
        trendingTableView.delegate = self
        trendingTableView.dataSource = self
    }
    // MARK: - Public methods
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
        
        switch indexPath.section {
        case TableSections.Trending.rawValue:
            NetworkService.shared.getTrendingTv { result in
                switch result {
                case .success(let tv):
                    cell.configure(with: tv)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case TableSections.Popular.rawValue:
            NetworkService.shared.getPopularTv { result in
                switch result {
                case .success(let tv):
                    cell.configure(with: tv)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
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
    
    // header height of title section
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    // header title setup
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
    
    // when cell is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}