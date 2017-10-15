//
//  ProfileView.swift
//  chatty
//
//  Created by Ethan Xue on 2017-08-07.
//  Copyright © 2017 xTech. All rights reserved.
//

import UIKit

class ProfileView: UICollectionViewCell {
    
    // MARK: Properties
    
    static let cellId = "ProfileView"
    
    private let coverPhoto: UIImageView = {
        let imageView = UIImageView(imageName: "chatty_launchscreen")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var profilePic: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.makeRounded()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont(name: FontRes.Avenir, size: 30)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont(name: FontRes.SanFran, size: 16.0)
        label.font = label.font.withSize(16.0)
        label.numberOfLines = 4
        return label
    }()
    
    fileprivate let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(theme: .bluegrey)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.printInit()
        addSubview(coverPhoto)
        addSubview(profilePic)
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(separatorView)
        setupCoverPhoto()
        setupProfilePic()
        setupNameLabel()
        setupDescriptionLabel()
        setupSeparatorView()
        
        additionalSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.printDeinit()
    }
    
    // MARK: Abstract functions
    
    fileprivate func additionalSetup() { }
    
    // MARK: Setup views
    
    private func setupCoverPhoto() {
        coverPhoto.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        coverPhoto.widthAnchor.constraint(equalTo:  self.widthAnchor).isActive = true
        coverPhoto.heightAnchor.constraint(equalToConstant: 150).isActive = true
        coverPhoto.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }
    
    private func setupProfilePic() {
        profilePic.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profilePic.heightAnchor.constraint(equalToConstant: 150).isActive = true
        profilePic.centerXAnchor.constraint(equalTo: coverPhoto.centerXAnchor).isActive = true
        profilePic.topAnchor.constraint(equalTo: coverPhoto.topAnchor, constant: 75).isActive = true
    }
    
    fileprivate func setupNameLabel() {
        nameLabel.topAnchor.constraint(equalTo: profilePic.bottomAnchor, constant: 40).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        descriptionLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -48).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 90).isActive = true
    }
    
    private func setupSeparatorView() {
        separatorView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20).isActive = true
        separatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        separatorView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 3).isActive = true
    }
}

class ContactProfileView: ProfileView {
    
    lazy var statusButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        button.setTitleColor(UIColor(theme: .purpleblue), for: .normal)
        button.titleLabel?.font = UIFont(name: FontRes.Avenir, size: 16.0)
        button.titleLabel?.font = button.titleLabel?.font.withSize(16.0)
        button.addTarget(self, action: #selector(handleStatusChange), for: .touchUpInside)
        return button
    }()
    
    override func additionalSetup() {
        addSubview(statusButton)
        setupStatusButton()
    }
    
    @objc private func handleStatusChange() {
        let contact = UserManagerService.shared().selectedContact
        if (contact?.statusCode == -1) { // send a friend request to a stranger
            contact?.statusCode? = 0
            statusButton.setTitle(UserManagerService.shared().selectedContact?.status, for: .normal)
            UserManagerService.shared().selectedContactDidUpdate = true
            guard let myId = UserManagerService.shared().myUser?.id, let otherId = contact?.id else {
                print(BaseError.optionalUnwrapError)
                return
            }
            _ = APIService.shared().updateRelation(forMyId: myId, otherId: otherId, relation: 0)
        }
    }
    private func setupStatusButton() {
        statusButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        statusButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        statusButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        statusButton.topAnchor.constraint(equalTo: separatorView.topAnchor, constant: 25).isActive = true
    }
}


