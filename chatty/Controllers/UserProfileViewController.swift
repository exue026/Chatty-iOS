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
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        print(className + " : " + "didLoad")
    }
}
