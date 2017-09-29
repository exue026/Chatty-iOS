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
    
    let photo: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.makeRounded()
        imageView.layer.borderWidth = 1.0
        imageView.image = UIImage(named: "profile_placeholder")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: FontRes.Avenir, size: 20.0)
        label.text = "Ethan Xue"
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12.0)
        return label
    }()
    
    let headLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16.0)
        return label
    }()
    
    let bodyLabel: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.white
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 14.0)
        textView.isUserInteractionEnabled = false
        return textView
    }()
    
    let commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "feed_comment"), for: .normal)
        return button
    }()
    
    let commentLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.text = "3"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.white
        addSubview(photo)
        setupPhoto()
        addSubview(nameLabel)
        setupNameLabel()
        addSubview(dateLabel)
        setupDateLabel()
        addSubview(headLabel)
        setupHeadLabel()
        addSubview(bodyLabel)
        setupBodyLabel()
        addSubview(commentLabel)
        setupCommentLabel()
        addSubview(commentButton)
        setupCommentButton()
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
        photo.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        photo.widthAnchor.constraint(equalToConstant: 40).isActive = true
        photo.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setupNameLabel() {
        nameLabel.leftAnchor.constraint(equalTo: photo.rightAnchor, constant: 12).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    private func setupDateLabel() {
        dateLabel.leftAnchor.constraint(equalTo: photo.rightAnchor, constant: 12).isActive = true
        dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func setupHeadLabel() {
        headLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 11).isActive = true
        headLabel.topAnchor.constraint(equalTo: photo.bottomAnchor, constant: 16).isActive = true
        headLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -6).isActive = true
        headLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupBodyLabel() {
        bodyLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 6).isActive = true
        bodyLabel.topAnchor.constraint(equalTo: headLabel.bottomAnchor, constant: 4).isActive = true
        bodyLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -6).isActive = true
        bodyLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6).isActive = true
    }
    
    private func setupCommentLabel() {
        commentLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        commentLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        commentLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        commentLabel.widthAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    private func setupCommentButton() {
        commentButton.rightAnchor.constraint(equalTo: commentLabel.leftAnchor, constant: -2).isActive = true
        commentButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        commentButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        commentButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
