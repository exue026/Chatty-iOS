//
//  ProfileSettingsController.swift
//  chatty
//
//  Created by Ethan Xue on 2017-07-30.
//  Copyright © 2017 xTech. All rights reserved.
//

import UIKit
import Firebase

class ProfileSettingsController: UIViewController {
    
    // MARK: Properties
    
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
    
    private var changePicButton: UIButton?
    private var changeNameButton: UIButton?
    private var changeDescriptionButton: UIButton?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.printDidLoad()
        view.backgroundColor = UIColor(theme: .bluegrey)
        
        navigationItem.title = "PROFILE_SETTINGS".localized()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "LOGOUT".localized(), style: .plain, target: self, action: #selector(handleLogout))
        
        createButtons()
        guard let changePicButton = changePicButton, let changeNameButton = changeNameButton,
            let changeDescriptionButton = changeDescriptionButton else { return }
        view.addSubview(changePicButton)
        view.addSubview(changeNameButton)
        view.addSubview(changeDescriptionButton)
        setupButtons()
    }
    
    deinit {
        self.printDeinit()
    }
    
    // MARK: Helper functions
    
    private func getButton(forTitle title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont(name: FontRes.SanFran, size: 22)
        button.setTitle(title, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(segueToProfileEdit(withSender:)), for: .touchUpInside)
        return button
    }
    
    private func createButtons() {
        changePicButton = getButton(forTitle: "CHANGE_PFP".localized())
        changeNameButton = getButton(forTitle: "EDIT_NAME".localized())
        changeDescriptionButton = getButton(forTitle: "EDIT_PF_DESCRIPTION".localized())
    }
    
    // MARK: Logout button target
    
    @objc private func handleLogout() {
        if FirebaseService.shared().logoutCurrentUser() {
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
                self.tabBarController?.selectedIndex = MainTabBarManagedControllers.newsFeedVC.rawValue
            }
            segueToLoginController()
        }
    }
    
    // MARK: Navigation
    
    @objc private func segueToLoginController() {
        present(LoginController(), animated: true, completion: nil)
    }
    
    @objc private func segueToProfileEdit(withSender button: UIButton) {
        let profileEditVC = ProfileEditController()
        profileEditVC.getData(data: button.titleLabel!.text!)
        present(profileEditVC, animated: true, completion: nil)
    }
    
    // MARK: Setup views

    private func setupButtons() {
        changePicButton?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        changePicButton?.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        changePicButton?.heightAnchor.constraint(equalToConstant: 50).isActive = true
        changePicButton?.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -26).isActive = true
        
        changeNameButton?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        changeNameButton?.topAnchor.constraint(equalTo: (changePicButton?.bottomAnchor)!, constant: 12).isActive = true
        changeNameButton?.heightAnchor.constraint(equalToConstant: 50).isActive = true
        changeNameButton?.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -26).isActive = true
        
        changeDescriptionButton?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        changeDescriptionButton?.topAnchor.constraint(equalTo: (changeNameButton?.bottomAnchor)!, constant: 12).isActive = true
        changeDescriptionButton?.heightAnchor.constraint(equalToConstant: 50).isActive = true
        changeDescriptionButton?.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -26).isActive = true
    }
}
