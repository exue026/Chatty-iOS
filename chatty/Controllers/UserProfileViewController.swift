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
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "ethan_face")
        imageView.makeRounded()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let infoView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        label.font = UIFont(name: FontRes.SanFran, size: 20)
        label.text = "CEO and Founder of xTech • Creator of Chatty • Student at University of Waterloo • Lifelong Learner • Software Engineer at Zeitspace"
        label.numberOfLines = 4
        return label
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
        profilePic.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profilePic.heightAnchor.constraint(equalToConstant: 150).isActive = true
        profilePic.centerXAnchor.constraint(equalTo: coverPhoto.centerXAnchor).isActive = true
        profilePic.topAnchor.constraint(equalTo: coverPhoto.topAnchor, constant: 140).isActive = true
    }
    
    private func setupInfoView() {
        infoView.heightAnchor.constraint(equalToConstant: 280).isActive = true
        infoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infoView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        infoView.topAnchor.constraint(equalTo: coverPhoto.bottomAnchor, constant: 65).isActive = true
        
        infoView.addSubview(nameLabel)
        infoView.addSubview(descriptionLabel)
        
        setupNameLabel()
        setupDescriptionLabel()
    }
    
    private func setupNameLabel() {
        nameLabel.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 90).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: infoView.centerXAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: infoView.centerXAnchor).isActive = true
        descriptionLabel.widthAnchor.constraint(equalTo: infoView.widthAnchor, constant: -48).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
}
