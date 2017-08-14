//
//  MainController.swift
//  chatty
//
//  Created by Ethan Xue on 2017-07-15.
//  Copyright © 2017 xTech. All rights reserved.
//

import UIKit
import PromiseKit

enum MainTabBarManagedControllers: Int {
    case newsFeedVC
    case userProfileVC
    case contactsVC
}

class MainTabBarController: UITabBarController {
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.printDidLoad()
        view.backgroundColor = UIColor.white
        tabBar.tintColor = UIColor(theme: .purpleblue)
        
        checkIfSignedIn()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !FirebaseService.shared().currentUserExists() {
            self.segueToLoginController()
        }
    }
    
    deinit {
        self.printDeinit()
    }
    
    // Helper functions
    
    private func checkIfSignedIn() {
        if FirebaseService.shared().currentUserExists(), UserManagerService.shared().myUser == nil {
            firstly {
                FirebaseService.shared().getIdToken()
                }.then { (idToken: String) -> Promise<User> in
                    APIService.shared().getUser(forIdToken: idToken)
                }.then { (user: User) -> Void in
                    UserManagerService.shared().myUser = user
                }.catch { error in
                    print(error)
                }.always {
                    self.setupManagedVCs()
            }
        }
    }
    
    private func setupManagedVCs() {
        let newsFeedVC = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        newsFeedVC.tabBarItem = UITabBarItem(title: "FEED".localized(), image: UIImage(named: "tab_bar_feed"), tag: MainTabBarManagedControllers.newsFeedVC.rawValue)
        
        let userProfileVC = UserProfileController(collectionViewLayout: UICollectionViewFlowLayout())
        userProfileVC.tabBarItem = UITabBarItem(title: "PROFILE".localized(), image: UIImage(named: "tab_bar_profile"), tag: MainTabBarManagedControllers.userProfileVC.rawValue)
        
        let contactsVC = ContactsController(collectionViewLayout: UICollectionViewFlowLayout())
        contactsVC.tabBarItem = UITabBarItem(title: "CONTACTS".localized(), image: UIImage(named: "tab_bar_contacts"), tag: MainTabBarManagedControllers.contactsVC.rawValue)
        
        viewControllers = [UINavigationController(rootViewController: newsFeedVC), UINavigationController(rootViewController: userProfileVC), UINavigationController(rootViewController: contactsVC)]
    }
    
    // MARK: Navigation
    
    private func segueToLoginController() {
        present(LoginController(), animated: true, completion: nil)
    }
}
