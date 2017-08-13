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
    let postedByUserWithId: Int?
}

extension Post: Decodable {
    enum PostKeys: String, CodingKey {
        case id, title, body, user_id, created_at, comments
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PostKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        text = try container.decodeIfPresent(String.self, forKey: .body)
        createdOn = try container.decodeIfPresent(Date.self, forKey: .created_at)
        postedByUserWithId = try container.decodeIfPresent(Int.self, forKey: .user_id)
        comments = try container.decodeIfPresent([Comment].self, forKey: .comments)
    }
}

