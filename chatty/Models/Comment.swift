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

extension Comment: Decodable {
    enum CommentKeys: String, CodingKey {
        case id, message, post_id, user_id, created_at
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CommentKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        text = try container.decodeIfPresent(String.self, forKey: .message)
        postedOn = try container.decodeIfPresent(Date.self, forKey: .created_at)
        postedByUserWithId = try container.decodeIfPresent(Int.self, forKey: .user_id)
        parentPost = try container.decodeIfPresent(Post.self, forKey: .post_id)
    }
}
