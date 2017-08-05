//
//  MainController.swift
//  chatty
//
//  Created by Ethan Xue on 2017-07-15.
//  Copyright © 2017 xTech. All rights reserved.
//

import UIKit

enum MainTabBarManagedControllers : Int {
    case newsFeedVC = 0
    case userProfileVC = 1
}

class MainTabBarController: UITabBarController {
    
    // MARK: Properties
    
    let className = String(typeOfClass: MainTabBarController.self)
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(className + " : " + "didLoad")
        view.backgroundColor = UIColor.white
        
        tabBar.tintColor = UIColor(theme: .purpleblue)
        
        let newsFeedVC = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        newsFeedVC.tabBarItem = UITabBarItem(title: "FEED".localized(), image: UIImage(named: "tab_bar_feed"), tag: MainTabBarManagedControllers.newsFeedVC.rawValue)
        
        let userProfileVC = UserProfileViewController()
        userProfileVC.tabBarItem = UITabBarItem(title: "PROFILE".localized(), image: UIImage(named: "tab_bar_profile"), tag: MainTabBarManagedControllers.userProfileVC.rawValue)
        
        viewControllers = [UINavigationController(rootViewController: newsFeedVC), UINavigationController(rootViewController: userProfileVC)]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("HELLOOOOOO")
        if !FirebaseService.shared().currentUserExists() {
            print("AYYYY")
            self.segueToLoginController()
        }
    }
    
    deinit {
        print(className + " : " + "deinitializing")
    }
    
    // MARK: Navigation
    
    private func segueToLoginController() {
        present(LoginController(), animated: true, completion: nil)
    }
}
