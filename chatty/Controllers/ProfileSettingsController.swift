//
//  ProfileSettingsController.swift
//  chatty
//
//  Created by Ethan Xue on 2017-07-30.
//  Copyright © 2017 xTech. All rights reserved.
//

import UIKit

class ProfileSettingsController: UIViewController {
    
    // MARK: Properties
    
    private let className = String(typeOfClass: ProfileSettingsController.self)
    
    private var isUpdated: Bool = true
    
    private let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(theme: .thistle)
        button.setTitle("LOGOUT".localized(), for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        return button
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(className + " : didLoad")
        view.backgroundColor = UIColor.white
        
        navigationItem.title = "PROFILE_SETTINGS".localized()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "LOGOUT".localized(), style: .plain, target: self, action: #selector(segueToLoginController))
    }
    
    deinit {
        print(className + " : deinitializing")
    }
    
    // MARK: Logout button target
    
    @objc private func handleLogout() {
        if FirebaseService.shared().logoutCurrentUser() {
            segueToLoginController()
        }
    }
    
    // MARK: Navigation
    
    @objc private func segueToLoginController() {
        present(LoginController(), animated: true, completion: nil)
    }
    
}
