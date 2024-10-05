//
//  MainTabBarController.swift
//  NewsApp
//
//  Created by Alisher Sultanov on 3/10/24.
//

import Foundation
import UIKit

final class MainTabBarController: UITabBarController {
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: Set up UI
    
    private func setUpUI() {
        tabBar.tintColor = .purple
        tabBar.unselectedItemTintColor = .gray
        tabBar.backgroundColor = .white
        setUpTabs()
    }
    
        private func setUpTabs() {
            let networkService = NetworkService.shared
    
            let newsModel = NewsModel(networkService: networkService)
            let newsVC = NewsVC(model: newsModel)
            let newsTabBarItem = UITabBarItem(
                title: (String(localized: "News")),
                image: UIImage(systemName: "newspaper"),
                selectedImage: UIImage(systemName: "newspaper")
            )
            newsVC.tabBarItem = newsTabBarItem
    
            let favModel = FavoritesModel()
            let favoritesVC = FavoritesVC(model: favModel)
            let favoritesTabBarItem = UITabBarItem(
                title: String(localized: "Favorites"),
                image: UIImage(systemName: "heart"),
                selectedImage: UIImage(systemName: "heart")
            )
            favoritesVC.tabBarItem = favoritesTabBarItem
    
            viewControllers = [newsVC, favoritesVC]
    
            viewControllers?.forEach { viewController in
                viewController.tabBarItem.setTitleTextAttributes(
                    [.font: UIFont.systemFont(ofSize: 14, weight: .medium) as Any],
                    for: .normal
                )
                viewController.tabBarItem.setTitleTextAttributes(
                    [.font: UIFont.systemFont(ofSize: 14, weight: .medium) as Any],
                    for: .selected
                )
            }
        }
    
    private func applyTabBarItemAttributes() {
        viewControllers?.forEach { viewController in
            viewController.tabBarItem.setTitleTextAttributes(
                [.font: UIFont.systemFont(ofSize: 14, weight: .medium) as Any],
                for: .normal
            )
            viewController.tabBarItem.setTitleTextAttributes(
                [.font: UIFont.systemFont(ofSize: 14, weight: .medium) as Any],
                for: .selected
            )
        }
    }
}

