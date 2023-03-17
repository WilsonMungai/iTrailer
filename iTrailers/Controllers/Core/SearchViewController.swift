//
//  SearchViewController.swift
//  iTrailers
//
//  Created by Wilson Mungai on 2023-03-07.
//

import UIKit

class SearchViewController: UIViewController {
  
    
    
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

        title = "Search"
        view.backgroundColor = .systemBackground
        
        // integrate the search controller onto our naivagation stack
        navigationItem.searchController = searchController
    }


}
