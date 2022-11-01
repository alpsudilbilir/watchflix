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
        let vc1         = HomeViewController()
        let vc2         = UpcomingViewController()
        let vc3         = SearchViewController()
        let vc4         =        ListsViewController()
                
        let nav1        = UINavigationController(rootViewController: vc1)
        let nav2        = UINavigationController(rootViewController: vc2)
        let nav3        = UINavigationController(rootViewController: vc3)
        let nav4        = UINavigationController(rootViewController: vc4)
        let navs        = [nav1, nav2, nav3, nav4]

        nav1.tabBarItem = UITabBarItem(title: "Home",     image: UIImage(systemName: SFSymbols.house), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Upcoming", image: UIImage(systemName: SFSymbols.upcoming), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Search",   image: UIImage(systemName: SFSymbols.search), tag: 3)
        nav4.tabBarItem = UITabBarItem(title: "Lists",    image: UIImage(systemName: SFSymbols.list), tag: 4)
        
        navs.forEach { nav in
            nav.navigationBar.prefersLargeTitles = true
            nav.navigationBar.tintColor          = .label
        }
        
        setViewControllers(navs, animated: true)
    }
}
