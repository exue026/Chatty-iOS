//
//  ContactCell.swift
//  chatty
//
//  Created by Ethan Xue on 2017-08-13.
//  Copyright © 2017 xTech. All rights reserved.
//

import UIKit

class ContactCell: UICollectionViewCell {
    
    // MARK: Properties
    
    static let cellId = "ContactCell"
    
    private let profilePic: UIImageView = {
        let imageView = UIImageView(imageName: "profile_placeholder")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.text = "e0026"
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: FontRes.Avenir, size: 14.0)
        label.text = "Ethan Xue"
        return label
    }()
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //self.printInit()
        self.backgroundColor = UIColor.white
        self.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(profilePic)
        addSubview(usernameLabel)
        addSubview(nameLabel)
        setupProfilePic()
        setupUsernameLabel()
        setupNameLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.printDeinit()
    }
    
    // MARK: Setup views
    
    private func setupProfilePic() {
        profilePic.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profilePic.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
        profilePic.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        profilePic.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
    }
    
    private func setupUsernameLabel() {
        usernameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        usernameLabel.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
        usernameLabel.heightAnchor.constraint(equalToConstant: 28).isActive = true
        usernameLabel.leftAnchor.constraint(equalTo: profilePic.rightAnchor, constant: 10).isActive = true
    }
    
    private func setupNameLabel() {
        nameLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 150.0).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: profilePic.rightAnchor, constant: 10).isActive = true
    }
}
