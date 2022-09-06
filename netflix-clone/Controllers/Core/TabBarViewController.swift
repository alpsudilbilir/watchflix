//
//  TabBarController.swift
//  netflix-clone
//
//  Created by Alpsu Dilbilir on 6.09.2022.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        let vc1 = HomeViewController()
        let vc2 = ComingSoonViewController()
        let vc3  = SearchViewController()
        let vc4 = DownloadsViewController()
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        let nav4 = UINavigationController(rootViewController: vc4)
        
        let navs = [nav1, nav2, nav3, nav4]
        navs.forEach { nav in
            nav.navigationBar.prefersLargeTitles = true
            nav.navigationBar.tintColor = .label
        }
        
        
        nav1.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            tag: 1)
        nav2.tabBarItem = UITabBarItem(
            title: "Coming soon",
            image: UIImage(systemName: "play.tv.fill"),
            tag: 2)
        nav3.tabBarItem = UITabBarItem(
            title: "Search",
            image: UIImage(systemName: "magnifyingglass"),
            tag: 3)
        nav4.tabBarItem = UITabBarItem(
            title: "Downloads",
            image: UIImage(systemName: "square.and.arrow.down"),
            tag: 4)
        
        setViewControllers(navs, animated: true)
    }
    
}
