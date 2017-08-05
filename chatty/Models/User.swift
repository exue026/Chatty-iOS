//
//  User.swift
//  chatty
//
//  Created by Ethan Xue on 2017-08-03.
//  Copyright © 2017 xTech. All rights reserved.
//

import Foundation
import UIKit

class User {
    
    // MARK: Properties
    
    let className = String(typeOfClass: User.self)
    
    private var uid: String
    private var username: String
    private var email: String
    private var firstName: String
    private var lastName: String
    private var description: String?
    private var pfp: UIImage?
    private var coverPhoto: UIImage?
    
    // MARK: Lifecycle
    
    init(uid: String, username: String, email: String, firstName: String, lastName: String, description: String? = nil, pfp: UIImage? = nil, coverPhoto: UIImage? = nil) {
        print(className + " : Initializing")
        self.uid = uid
        self.username = username
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.description = description
        self.pfp = pfp
        self.coverPhoto = coverPhoto
    }
    
    deinit {
        print(className + " : Deinitializing")
    }
}
