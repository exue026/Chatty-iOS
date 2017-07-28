//
//  MainController.swift
//  chatty
//
//  Created by Ethan Xue on 2017-07-15.
//  Copyright © 2017 xTech. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    // MARK: Properties
    
    let className = String(typeOfClass: MainTabBarController.self)
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(className + " : " + "didLoad")
        view.backgroundColor = UIColor.white
        
        let userProfileVC = UserProfileViewController()
        userProfileVC.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.contacts, tag: 0)
        
        viewControllers = [UINavigationController(rootViewController: userProfileVC)]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !FirebaseService.shared().currentUserExists() {
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
