//
//  User.swift
//  chatty
//
//  Created by Ethan Xue on 2017-08-03.
//  Copyright © 2017 xTech. All rights reserved.
//

import UIKit

class User {
    
    // MARK: Properties
    
    let uid: String?
    var username: String?
    let id: Int?
    var displayName: String?
    var posts: [Post]?
    var descript: String?
    var pfp: UIImage?
    var coverPhoto: UIImage?
    var statusCode: Int? { // 0 = pending, 1 = friends, else not friends
        didSet {
            setStatus()
        }
    }
    var status: String?
    
    init(json: [String: Any]) {
        uid = json["uid"] as? String ?? nil
        username = json["username"] as? String ?? nil
        id = json["id"] as? Int ?? nil
        displayName = json["name"] as? String ?? nil
        posts = json["posts"] as? [Post] ?? nil
        descript = json["description"] as? String ?? nil
        pfp = nil
        coverPhoto = nil
        statusCode = json["statusCode"] as? Int ?? -1
        setStatus()
    }
    
    private func setStatus() {
        switch(statusCode!) {
        case 0:
            status = "REQUEST_PENDING".localized()
        case 1:
            status = "CONTACT".localized()
        default:
            status = "ADD_CONTACT".localized()
        }
    }
    
    //for testing purposes
    
    init(username: String, displayName: String, description: String, statusCode: Int) {
        uid = nil
        self.username = username
        id = nil
        self.displayName = displayName
        posts = nil
        self.descript = description
        pfp = nil
        coverPhoto = nil
        self.statusCode = statusCode
        setStatus()
    }
}

extension User {
    enum keys: String {
        case id, name, uid, username, description, posts
    }
}
/*
extension User: Decodable {
    enum UserKeys: String {
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
*/
