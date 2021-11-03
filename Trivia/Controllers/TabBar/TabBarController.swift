//
//  TabBarController.swift
//  Trivia
//
//  Created by Sebastian San Blas on 29/10/2021.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        tabBar.tintColor = UIColor(red: 82/255, green: 196/255, blue: 255/255, alpha: 1)
        tabBar.backgroundColor = .clear
        tabBar.barTintColor = UIColor(red: 206/255, green: 238/255, blue: 255/255, alpha: 1)
        self.delegate = self
    }

    func setupViewControllers() {
        viewControllers = [
            createNavController(for: QuestionViewController(), title: NSLocalizedString("Random", comment: ""), image: UIImage(systemName: "shuffle")!),
            createNavController(for: CategoriesViewController(), title: NSLocalizedString("Categories", comment: ""), image: UIImage(systemName: "list.dash")!),
        ]
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        (viewController as? UINavigationController)?.popToRootViewController(animated: true)
        return true
    }
}

// MARK: Controllers creator

extension TabBarController {
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                                    title: String,
                                                    image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.image = image
        rootViewController.title = title
        rootViewController.navigationItem.title = title
        return navController
    }
}
