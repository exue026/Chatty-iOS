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
        let imageView = UIImageView(imageName: "chatty_launchscreen")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let profilePic: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "ethan_face")
        imageView.makeRounded()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.text = "Ethan Xue"
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont(name: FontRes.Avenir, size: 30)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont(name: FontRes.SanFran, size: 16.0)
        label.font = label.font.withSize(16.0)
        label.text = "CEO and Founder of xTech • Creator of Chatty • Student at University of Waterloo • Software Engineer • Lifelong Learner"
        label.numberOfLines = 4
        return label
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(theme: .thistle)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let profilePager: ProfilePager = {
        let pager = ProfilePager()
        pager.translatesAutoresizingMaskIntoConstraints = false
        return pager
    }()
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        print(className + " : " + "didLoad")
        view.backgroundColor = UIColor.white
        self.edgesForExtendedLayout = []
        
        navigationItem.title = "PROFILE".localized()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "SETTINGS".localized(), style: .plain, target: self, action: #selector(segueToProfileSettings))
        navigationController?.navigationBar.isTranslucent = false
        
        view.addSubview(profilePager)
        view.addSubview(coverPhoto)
        view.addSubview(profilePic)
        view.addSubview(nameLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(separatorView)
        setupProfilePager()
        setupCoverPhoto()
        setupProfilePic()
        setupNameLabel()
        setupDescriptionLabel()
        setupSeparatorView()
    }
    
    deinit {
        print(className + " : " + "deinitializing")
    }
    
    // MARK: Navigation
    
    @objc private func segueToProfileSettings() {
        navigationController?.pushViewController(ProfileSettingsController(), animated: true)
    }
    
    // MARK: Setup views
    
    private func setupProfilePager() {
        profilePager.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        profilePager.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        profilePager.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profilePager.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupCoverPhoto() {
        coverPhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        coverPhoto.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        coverPhoto.heightAnchor.constraint(equalToConstant: 150).isActive = true
        coverPhoto.topAnchor.constraint(equalTo: profilePager.bottomAnchor).isActive = true
    }
    
    private func setupProfilePic() {
        profilePic.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profilePic.heightAnchor.constraint(equalToConstant: 150).isActive = true
        profilePic.centerXAnchor.constraint(equalTo: coverPhoto.centerXAnchor).isActive = true
        profilePic.topAnchor.constraint(equalTo: coverPhoto.topAnchor, constant: 75).isActive = true
    }
    
    private func setupNameLabel() {
        nameLabel.topAnchor.constraint(equalTo: profilePic.bottomAnchor, constant: 40).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        descriptionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -48).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 90).isActive = true
    }
    
    private func setupSeparatorView() {
        separatorView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20).isActive = true
        separatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        separatorView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 3).isActive = true
    }
}
