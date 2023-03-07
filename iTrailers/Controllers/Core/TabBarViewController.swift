//
//  TabBarViewController.swift
//  iTrailers
//
//  Created by Wilson Mungai on 2023-03-07.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
        
    }
    
    // MARK: - Tab Setup
    private func setUpTabs() {
        let homeVC = HomeViewController()
        let trendingVC = TrendingViewController()
        let searchVC = SearchViewController()
        let downloadVC = DownloadViewController()
        
        // set large titles
        homeVC.navigationItem.largeTitleDisplayMode = .automatic
        trendingVC.navigationItem.largeTitleDisplayMode = .automatic
        searchVC.navigationItem.largeTitleDisplayMode = .automatic
        downloadVC.navigationItem.largeTitleDisplayMode = .automatic
        
        // embed views into a navigation controller
        let navHome = UINavigationController(rootViewController: homeVC)
        let navTrending = UINavigationController(rootViewController: trendingVC)
        let navSearch = UINavigationController(rootViewController: searchVC)
        let navDownload = UINavigationController(rootViewController: downloadVC)
        
        // set title and tab bar icons
        navHome.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        navTrending.tabBarItem = UITabBarItem(title: "Trending", image: UIImage(systemName: "flame"), selectedImage: UIImage(systemName: "flame.fill"))
        navSearch.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass.circle"), selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))
        navDownload.tabBarItem = UITabBarItem(title: "Download", image: UIImage(systemName: "arrow.down.app"), selectedImage: UIImage(systemName: "arrow.down.app.fill"))
        
        
        
        // display large titles
        for nav in [navHome, navTrending, navSearch, navDownload] {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        // attach view controller to tabs
        setViewControllers([navHome, navTrending, navSearch, navDownload], animated: true)
        
    }

}
