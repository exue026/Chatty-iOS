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
    var updatedInfo: Bool = false
    
    func updateUserInfo(info: [String: String]) -> Promise<Data?> {
        guard let id = myUser?.id else {
            return Promise(error: BaseError.unknownError)
        }
        return APIService.shared().updateUser(forId: id, info: info)
    }
    
    // MARK: Initializers
    
    private init() { }
    
    static func shared() -> UserManagerService {
        return sharedInstance;
    }
}
