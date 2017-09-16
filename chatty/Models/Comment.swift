//
//  Comment.swift
//  chatty
//
//  Created by Ethan Xue on 2017-08-03.
//  Copyright © 2017 xTech. All rights reserved.
//

import UIKit

struct Comment {
    let id: Int?
    let text: String?
    let postedOn: Date?
    let postedByUserWithId: Int?
    let parentPost: Post?
}

extension Comment {
    enum CommentKeys: String {
        case id, message, post_id, user_id, created_at
    }
}
