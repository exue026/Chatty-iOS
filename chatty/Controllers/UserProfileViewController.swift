//
//  UserProfileControllerViewController.swift
//  chatty
//
//  Created by Ethan Xue on 2017-07-18.
//  Copyright © 2017 xTech. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    // MARK: Properties
    
    let className = String(typeOfClass: UserProfileViewController.self)
    
    private let coverPhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "chatty_launchscreen")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let profilePic: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "ethan_face")
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let spinner = LoadingSpinner(frame: CGRect.zero)
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        print(className + " : " + "didLoad")
        view.backgroundColor = UIColor(theme: .purpleblue)
        
        self.navigationItem.title = "PROFILE".localized()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "LOGOUT".localized(), style: .plain, target: self, action: #selector(handleLogout))
        
        view.addSubview(coverPhoto)
        setupCoverPhoto()
    }
    
    deinit {
        print(className + " : " + "deinitializing")
    }
    
    // MARK: Logout button target
    
    @objc private func handleLogout() {
        if FirebaseService.shared().logoutCurrentUser() {
            segueToLoginController()
        }
    }
    
    // MARK: Navigation
    
    private func segueToLoginController() {
        present(LoginController(), animated: true, completion: nil)
    }
    
    // MARK: Setup views
    
    private func setupCoverPhoto() {
        coverPhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        coverPhoto.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        coverPhoto.heightAnchor.constraint(equalToConstant: 150).isActive = true
        coverPhoto.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
   
        coverPhoto.addSubview(profilePic)
        
        setupProfilePic()
    }
    
    private func setupProfilePic() {
        profilePic.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profilePic.heightAnchor.constraint(equalToConstant: 100).isActive = true
        profilePic.centerXAnchor.constraint(equalTo: coverPhoto.centerXAnchor).isActive = true
        profilePic.topAnchor.constraint(equalTo: coverPhoto.topAnchor, constant: 170).isActive = true
    }
}
