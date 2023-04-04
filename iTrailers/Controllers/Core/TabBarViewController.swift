//
//  TabBarViewController.swift
//  iTrailers
//
//  Created by Wilson Mungai on 2023-03-07.
//

import UIKit
// responsible for holding tab bar items
class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpTabs()
    }
    
    // MARK: - Tab Setup
    private func setUpTabs() {
        let homeVC = HomeViewController()
        let trendingVC = ShowsViewController()
        let searchVC = DiscoverViewController()
        let favouritesVC = FavouritesViewController()
        
        // set large titles
        homeVC.navigationItem.largeTitleDisplayMode = .automatic
        trendingVC.navigationItem.largeTitleDisplayMode = .automatic
        searchVC.navigationItem.largeTitleDisplayMode = .automatic
        favouritesVC.navigationItem.largeTitleDisplayMode = .automatic
        
        // embed views into a navigation controller
        let navHome = UINavigationController(rootViewController: homeVC)
        let navTrending = UINavigationController(rootViewController: trendingVC)
        let navSearch = UINavigationController(rootViewController: searchVC)
        let navFavourites = UINavigationController(rootViewController: favouritesVC)
        
        // set title and tab bar icons
        // home tab
        navHome.tabBarItem = UITabBarItem(title: "Home",
                                          image: UIImage(systemName: "house"),
                                          selectedImage: UIImage(systemName: "house.fill"))
        
        // trending tab
        navTrending.tabBarItem = UITabBarItem(title: "TV Show",
                                              image: UIImage(systemName: "popcorn"),
                                              selectedImage: UIImage(systemName: "popcorn.fill"))
        
        // search tab
        navSearch.tabBarItem = UITabBarItem(title: "Discover",
                                            image: UIImage(systemName: "magnifyingglass.circle"),
                                            selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))
        
        // favourites tab
        navFavourites.tabBarItem = UITabBarItem(title: "Favourites",
                                              image: UIImage(systemName: "heart"),
                                              selectedImage: UIImage(systemName: "heart.fill"))
        
        // display large titles
        for nav in [navHome, navTrending, navSearch, navFavourites] {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        // attach view controller to tabs
        setViewControllers([navHome, navTrending, navSearch, navFavourites], animated: true)
        
        // change tint color
//        tabBar.tintColor = .label
    }
}
