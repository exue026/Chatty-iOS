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
    
    private let infoView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(theme: .bluegrey)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        print(className + " : " + "didLoad")
        view.backgroundColor = UIColor(theme: .purpleblue)
        
        navigationItem.title = "PROFILE".localized()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "SETTINGS".localized(), style: .plain, target: self, action: #selector(segueToProfileSettings))
        
        view.addSubview(coverPhoto)
        view.insertSubview(infoView, belowSubview: coverPhoto)
        
        setupCoverPhoto()
        setupInfoView()
    }
    
    deinit {
        print(className + " : " + "deinitializing")
    }
    
    // MARK: Navigation
    
    @objc private func segueToProfileSettings() {
        navigationController?.pushViewController(ProfileSettingsController(), animated: true)
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
        profilePic.topAnchor.constraint(equalTo: coverPhoto.topAnchor, constant: 160).isActive = true
    }
    
    private func setupInfoView() {
        infoView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        infoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infoView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        infoView.topAnchor.constraint(equalTo: coverPhoto.bottomAnchor, constant: 65).isActive = true
    }
}
