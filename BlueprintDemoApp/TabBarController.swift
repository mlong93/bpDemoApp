//
//  TabBarController.swift
//  BlueprintDemoApp
//
//  Created by Mindy Long on 2/20/21.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
    }
    
    func setUpViews() {
        viewControllers = [createTabBarItem(title: "Movies", imageName: "rectangle.stack", viewController: MovieTableViewController()), createTabBarItem(title: "Me", imageName: "person", viewController: HomeViewController())]
    }
    
    private func createTabBarItem(title: String, imageName: String, viewController: UIViewController) -> UINavigationController {
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(systemName: imageName)
        
        return navController
    }
    
}
