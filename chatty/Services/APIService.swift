//
//  APIService.swift
//  chatty
//
//  Created by Ethan Xue on 2017-07-12.
//  Copyright © 2017 xTech. All rights reserved.
//

import Foundation

class APIService {
    
    // MARK: Properties
    
    let className = String(typeOfClass: APIService.self)
    
    private static let sharedInstance = {
        return APIService()
    }()
    
    // MARK: Initializers
    
    private init() {
    }
    
    // MARK: Helper Functions
    
    static func shared() -> APIService {
        return sharedInstance
    }
}
