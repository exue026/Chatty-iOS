//
//  Comment.swift
//  chatty
//
//  Created by Ethan Xue on 2017-08-03.
//  Copyright © 2017 xTech. All rights reserved.
//

import Foundation
import UIKit

class Comment {
    
    // MARK: Properties
    var className : String {
        get { return String(typeOfClass: Comment.self) }
    }
    var user: User
    var text: String
    var date: Date
    
    // MARK: Lifecycle
    
    init(postedBy user: User, text: String, date: Date) {
        print("Comment : Initializing")
        self.user = user
        self.text = text
        self.date = date
    }
    
    deinit {
        print("Comment : Deinitializing")
    }
    
}
