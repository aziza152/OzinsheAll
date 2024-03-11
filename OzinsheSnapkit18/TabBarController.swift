//
//  TabBarController.swift
//  OzinsheSnapkit18
//
//  Created by Aziza on 14.02.2024.
//

import Foundation
import UIKit
import Localize_Swift

class TabBarController: UITabBarController {

    let homeVC = UINavigationController(rootViewController: MainPageViewController())
    let searchVC = UINavigationController(rootViewController: SearchViewController())
    let favoriteVC = UINavigationController(rootViewController: FavoriteViewController())
    let profileVC = UINavigationController(rootViewController: ProfileViewController())

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabImages()
        
        tabBar.backgroundColor = UIColor(named: "FFFFFF - 1C2431")
        tabBar.barTintColor = UIColor(named: "FFFFFF-1C2431")
     //   tabBar.isTranslucent = false
        
    }
    
    func setTabImages() {

        homeVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Home"), selectedImage: UIImage(named: "HomeSelected")?.withRenderingMode(.alwaysOriginal))
        searchVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Search"), selectedImage: UIImage(named: "SearchSelected")?.withRenderingMode(.alwaysOriginal))
        favoriteVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Favorite"), selectedImage: UIImage(named: "FavoriteSelected")?.withRenderingMode(.alwaysOriginal))
        profileVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Profile"), selectedImage: UIImage(named: "ProfileSelected")?.withRenderingMode(.alwaysOriginal))

       setViewControllers([homeVC, searchVC, favoriteVC, profileVC], animated: true)

//        homeVC.navigationItem.title = ""
//        searchVC.navigationItem.title = "SEARCH".localized()
//        favoriteVC.navigationItem.title = "LIST".localized()
//       profileVC.navigationItem.title = "PROFILE".localized()
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setupSelectedImage()
    }

    func setupSelectedImage(){
        let homeSelectedImage = UIImage(named: "HomeSelected")?.withRenderingMode(.alwaysOriginal)
        let searchSelectedImage = UIImage(named: "SearchSelected")?.withRenderingMode(.alwaysOriginal)
        let favoritesSelectedImage = UIImage(named: "FavoriteSelected")?.withRenderingMode(.alwaysOriginal)
        let profileSelectedImage = UIImage(named: "ProfileSelected")?.withRenderingMode(.alwaysOriginal)

        if let items = tabBar.items {
            items[0].selectedImage = homeSelectedImage
            items[1].selectedImage = searchSelectedImage
            items[2].selectedImage = favoritesSelectedImage
            items[3].selectedImage = profileSelectedImage
        }
    }
}


    // let appearance = UITabBarAppearance()
  //
  //        override func viewDidLoad() {
  //            super.viewDidLoad()
  //
  //            configure()
  //        }
  //        override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
  //            super.traitCollectionDidChange(previousTraitCollection)
  //
  //            if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
  //                updateSelectedImagesForCurrentAppearance()
  //            }
  //        }
  //        func configure() {
  //            let home = MainPageViewController()
  //            let search = SearchViewController()
  //            let favorites = FavoriteViewController()
  //            let profile = ProfileViewController()
  //
  //            tabBar.backgroundColor = UIColor(named: "FFFFFF-1C2431")
  //
  //
  //            home.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Home"), selectedImage: UIImage(named: "HomeSelected"))
  //            search.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Search"), selectedImage: UIImage(named: "SearchSelected"))
  //            favorites.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Favorite"), selectedImage: UIImage(named: "FavoriteSelected"))
  //            profile.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Profile"), selectedImage: UIImage(named: "ProfileSelected"))
  //
  //            let nc1 = UINavigationController(rootViewController: home)
  //            let nc2 = UINavigationController(rootViewController: search)
  //            let nc3 = UINavigationController(rootViewController: favorites)
  //            let nc4 = UINavigationController(rootViewController: profile)
  //
  //            setViewControllers([nc1, nc2, nc3, nc4], animated: true)
  //
  //            home.navigationItem.title = ""
  //            search.navigationItem.title = "SEARCH".localized()
  //            favorites.navigationItem.title = "LIST".localized()
  //            profile.navigationItem.title = "PROFILE".localized()
  //        }
  //
  //        func updateSelectedImagesForCurrentAppearance() {
  //            let homeSelectedImage = UIImage(named: "HomeSelected")?.withRenderingMode(.alwaysOriginal)
  //            let searchSelectedImage = UIImage(named: "SearchSelected")?.withRenderingMode(.alwaysOriginal)
  //            let favoritesSelectedImage = UIImage(named: "FavoriteSelected")?.withRenderingMode(.alwaysOriginal)
  //            let profileSelectedImage = UIImage(named: "ProfileSelected")?.withRenderingMode(.alwaysOriginal)
  //
  //            if let items = tabBar.items {
  //                items[0].selectedImage = homeSelectedImage
  //                items[1].selectedImage = searchSelectedImage
  //                items[2].selectedImage = favoritesSelectedImage
  //                items[3].selectedImage = profileSelectedImage
  //            }
  //        }
  //    }
  //
