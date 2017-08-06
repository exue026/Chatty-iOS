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
    
    var className: String {
        get { return String(typeOfClass: User.self) }
    }
    let username: String
    var firstName: String
    var lastName: String
    var description: String?
    var pfp: UIImage?
    var coverPhoto: UIImage?
    
    // MARK: Lifecycle
    
    init(username: String, firstName: String, lastName: String, description: String? = nil, pfp: UIImage? = nil, coverPhoto: UIImage? = nil) {
        self.username = username
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
