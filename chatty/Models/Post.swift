//
//  Post.swift
//  chatty
//
//  Created by Ethan Xue on 2017-08-03.
//  Copyright © 2017 xTech. All rights reserved.
//

import Foundation
import UIKit

class Post : Comment {
    
    // MARK: Properties
    override var className: String {
        get { return String(typeOfClass: Post.self) }
    }
    var title: String
    var comments: [Comment]
    
    // MARK: Lifecycle
    
    init(postedBy user: User, text: String, date: Date, title: String, comments: [Comment]) {
        self.title = title
        self.comments = comments
        super.init(postedBy: user, text: text, date: date)
        print(className + " : Initializing")
    }
    
    deinit {
        print(className + " : Deinitializing")
    }
    
    
}

