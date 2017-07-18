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
    
    // MARK: Initializers and deinitializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(className + " : " + "didLoad")
        
        view.backgroundColor = UIColor(theme: .purpleblue)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
        let userProfileVC = UserProfileControllerViewController()
        userProfileVC.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.contacts, tag: 0)
        
        viewControllers = [userProfileVC]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    deinit {
        print(className + " : " + "deinitializing")
    }
    
    @objc private func handleLogout() {
        if FirebaseService.shared().logoutCurrentUser() {
            navigationController?.popViewController(animated: true)
        }
    }
}
