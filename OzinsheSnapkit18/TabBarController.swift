//
//  TabBarController.swift
//  OzinsheSnapkit18
//
//  Created by Aziza on 14.02.2024.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabImages()
        
        tabBar.backgroundColor = UIColor(named: "FFFFFF - 1C2431")
    }
    
    func setTabImages() {
        let homeVC = MainPageViewController()
        let searchVC = SearchViewController()
        let favoriteVC = FavoriteViewController()
        let profileVC = ProfileViewController()
        
        homeVC.tabBarItem.image = UIImage(named: "Home")?.withRenderingMode(.alwaysOriginal)
        homeVC.tabBarItem.selectedImage = UIImage(named: "HomeSelected")?.withRenderingMode(.alwaysOriginal)
        
        searchVC.tabBarItem.image = UIImage(named: "Search")?.withRenderingMode(.alwaysOriginal)
        searchVC.tabBarItem.selectedImage = UIImage(named: "SearchSelected")?.withRenderingMode(.alwaysOriginal)
        
        favoriteVC.tabBarItem.image = UIImage(named: "Favorite")?.withRenderingMode(.alwaysOriginal)
        favoriteVC.tabBarItem.selectedImage = UIImage(named: "FavoriteSelected")?.withRenderingMode(.alwaysOriginal)
        
        profileVC.tabBarItem.image = UIImage(named: "Profile")?.withRenderingMode(.alwaysOriginal)
        profileVC.tabBarItem.selectedImage = UIImage(named: "ProfileSelected")?.withRenderingMode(.alwaysOriginal)
        
        
        let navigationHomeVc = UINavigationController(rootViewController: homeVC)
        let navigationSearchVc = UINavigationController(rootViewController: searchVC)
        let navigationFavoriteVc = UINavigationController(rootViewController: favoriteVC)
        let navigationProfileVc = UINavigationController(rootViewController: profileVC)
        
        setViewControllers([navigationHomeVc, navigationSearchVc, navigationFavoriteVc, navigationProfileVc], animated: true)
    }
}
