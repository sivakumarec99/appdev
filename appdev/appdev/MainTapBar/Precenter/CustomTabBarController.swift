//
//  CustomTabBarController.swift
//  appdev
//
//  Created by JIDTP1408 on 04/02/25.
//

import UIKit

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
    }
    
    private func setupTabBar() {
        self.delegate = self  // Set delegate to handle animations
        
        let productListVC = ProductListViewController()
        let folderVC = FolderViewController()
        let profileVC = WebViewController()

        // Assign Tab Bar Items with Icons
        productListVC.tabBarItem = createTabBarItem(title: "Home", imageName: "house")
        folderVC.tabBarItem = createTabBarItem(title: "Folder", imageName: "folder")
        profileVC.tabBarItem = createTabBarItem(title: "Profile", imageName: "person")

        // Wrap inside UINavigationController (optional)
        let homeNav = UINavigationController(rootViewController: productListVC)
        let searchNav = UINavigationController(rootViewController: folderVC)
        let profileNav = UINavigationController(rootViewController: profileVC)

        viewControllers = [homeNav, searchNav, profileNav]
        
        setupTabBarAppearance()
    }

    private func createTabBarItem(title: String, imageName: String) -> UITabBarItem {
        let tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: imageName), tag: 0)
        
        // Default and selected colors
        tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.systemGray], for: .normal)
        tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.systemBlue], for: .selected)
        
        return tabBarItem
    }

    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBackground
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        } else {
            // Fallback on earlier versions
        }
    }
    
    // MARK: - Animate Tab Selection
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let index = tabBar.items?.firstIndex(of: item) else { return }

        let tabBarItemViews = tabBar.subviews.filter { $0 is UIControl } // Get only tab buttons
        guard index < tabBarItemViews.count else { return } // Ensure index is valid

        let tabBarItemView = tabBarItemViews[index]

        // Animate tab selection
        UIView.animate(withDuration: 0.3,
                       animations: {
                        tabBarItemView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                       }) { _ in
            UIView.animate(withDuration: 0.3) {
                tabBarItemView.transform = CGAffineTransform.identity
            }
        }
    }
}
