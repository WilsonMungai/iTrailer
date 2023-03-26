//
//  SearchViewController.swift
//  iTrailers
//
//  Created by Wilson Mungai on 2023-03-07.
//

import UIKit

class SearchViewController: UIViewController {
  
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
        
        // integrate the search controller onto our naivagation stack
        navigationItem.searchController = searchController
        
        tabelViewSetup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchTabelView.frame = view.bounds
    }
    
    private func tabelViewSetup() {
        searchTabelView.delegate = self
        searchTabelView.dataSource = self
    }


}

// MARK: - Table view extension
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PosterTableViewCell.cellIdentifier, for: indexPath)
//        cell.backgroundColor = .systemCyan
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

