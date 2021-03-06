//
//  Post.swift
//  chatty
//
//  Created by Ethan Xue on 2017-08-03.
//  Copyright © 2017 xTech. All rights reserved.
//

import UIKit

struct Post {
    
    // MARK: Properties
    
    let id: Int?
    let title: String?
    let comments: [Comment]?
    let text: String?
    let createdOn: Date?
    let timeSinceNow: String?
    let postedByUserWithId: Int?
    
    init(title: String, text: String) {
        self.title = title
        self.text = text
        id = nil
        comments = nil
        createdOn = Date()
        postedByUserWithId = nil
        timeSinceNow = createdOn?.getTimeSinceNow()
    }
    
    init(json: [String: Any]) {
        id = json[PostKeys.id.rawValue] as? Int ?? nil
        title = json[PostKeys.head.rawValue] as? String ?? nil
        text = json[PostKeys.body.rawValue] as? String ?? nil
        comments = nil
        createdOn = (json[PostKeys.created_at.rawValue] as? String)?.toDate()
        timeSinceNow = createdOn?.getTimeSinceNow()
        postedByUserWithId = json["user_id"] as? Int ?? nil
    }
}

extension Post {
    enum PostKeys: String {
        case id, head, body, user_id, created_at, comments
    }
}

