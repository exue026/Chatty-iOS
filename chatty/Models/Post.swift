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
    
    var title: String
    var comments: [Comment]
    
    // MARK: Lifecycle
    
    init(postedBy user: User, text: String, date: Date, title: String, comments: [Comment]) {
        print("Post : Initializing")
        self.title = title
        self.comments = comments
        super.init(postedBy: user, text: text, date: date)
    }
    
    deinit {
        print("Post : Deinitializing")
    }
    
    
}

