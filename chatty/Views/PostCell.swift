//
//  PostCell.swift
//  chatty
//
//  Created by Ethan Xue on 2017-08-14.
//  Copyright © 2017 xTech. All rights reserved.
//

import UIKit

class PostCell: UICollectionViewCell {
    
    static let cellId = "PostCell"
    
    private let photo: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.makeRounded()
        imageView.layer.borderWidth = 1.0
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "profile_placeholder")
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: FontRes.Avenir, size: 18.0)
        label.text = "Ethan Xue"
        return label
    }()
    
    let headLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.text = "My first day at University of Waterloo"
        return label
    }()
    
    let bodyLabel: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.white
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 14.0)
        textView.text = "My first day at University of Waterloo was an amazing experience. I had a lot of fun applying to doing different things and stuff. I'm looking forward to the remaining days I have in this term."
        textView.isUserInteractionEnabled = false
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.white
        addSubview(photo)
        setupPhoto()
        addSubview(nameLabel)
        setupNameLabel()
        addSubview(headLabel)
        setupHeadLabel()
        addSubview(bodyLabel)
        setupBodyLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.printDeinit()
    }
    
    // Setup views
    
    private func setupPhoto() {
        photo.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 6).isActive = true
        photo.topAnchor.constraint(equalTo: self.topAnchor, constant: 6).isActive = true
        photo.widthAnchor.constraint(equalToConstant: 40).isActive = true
        photo.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setupNameLabel() {
        nameLabel.leftAnchor.constraint(equalTo: photo.rightAnchor, constant: 12).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 7).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    private func setupHeadLabel() {
        headLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 11).isActive = true
        headLabel.topAnchor.constraint(equalTo: photo.bottomAnchor, constant: 12).isActive = true
        headLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -6).isActive = true
        headLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupBodyLabel() {
        bodyLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 6).isActive = true
        bodyLabel.topAnchor.constraint(equalTo: headLabel.bottomAnchor, constant: 6).isActive = true
        bodyLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -6).isActive = true
        bodyLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6).isActive = true
    }
}
