//
//  UserManagerService.swift
//  chatty
//
//  Created by Ethan Xue on 2017-08-09.
//  Copyright © 2017 xTech. All rights reserved.
//

import Foundation
import PromiseKit

class UserManagerService {
    
    // MARK: Properties
    
    private static let sharedInstance = {
        return UserManagerService()
    }()
    
    var myUser: User?
    var contacts: [User]?
    var posts: [Post]?
    var selectedContact: User?
    var updatedInfo: Bool = false
    var updatedPosts: Bool = false
    var updatedContacts: Bool = false
    
    func updateUserInfo(info: [String: String]) -> Promise<Data?> {
        guard let id = myUser?.id else {
            return Promise(error: BaseError.unknownError)
        }
        return APIService.shared().updateUser(forId: id, info: info)
    }
    
    // MARK: Initializers
    
    private init() {
        /*
        let contact1 = User(username: "chenboi", displayName: "George Chen", description: "Treasurer at Orchard Commons Residence Association. Student at University of British Columbia. Went to Burnaby North Secondary.", statusCode: 0)
        let contact2 = User(username: "jamal", displayName: "Thomson Mai", description: "UBC Civil", statusCode: 0)
        let contact3 = User(username: "brady_liu", displayName: "Brady Liu", description: "BNSS'16 | CUDAS | When life gets hard, just keep swimming :)", statusCode: 0)
 
        contacts = [contact1, contact2, contact3]
         */
    }
    
    static func shared() -> UserManagerService {
        return sharedInstance;
    }
}
