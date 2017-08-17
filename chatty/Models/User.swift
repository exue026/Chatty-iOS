//
//  User.swift
//  chatty
//
//  Created by Ethan Xue on 2017-08-03.
//  Copyright © 2017 xTech. All rights reserved.
//

import UIKit

struct User {
    
    // MARK: Properties
    
    let uid: String?
    let username: String?
    let id: Int?
    var displayName: String?
    var posts: [Post]?
    var descript: String?
    var pfp: UIImage?
    var coverPhoto: UIImage?
    
    init(username: String, displayName: String, description: String) {
        self.username = username
        self.displayName = displayName
        uid = nil
        id = nil
        posts = nil
        descript = description
        pfp = nil
        coverPhoto = nil
    }
}

extension User: Decodable {
    enum UserKeys: String, CodingKey {
        case id, name, uid, username, description, posts
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserKeys.self)
        uid = try container.decodeIfPresent(String.self, forKey: .uid)
        username = try container.decodeIfPresent(String.self, forKey: .username)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        displayName = try container.decodeIfPresent(String.self, forKey: .name)
        posts = try container.decodeIfPresent([Post].self, forKey: .posts)
        descript = try container.decodeIfPresent(String.self, forKey: .description)
    }
}

