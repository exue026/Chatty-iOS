//
//  APIService.swift
//  chatty
//
//  Created by Ethan Xue on 2017-07-12.
//  Copyright © 2017 xTech. All rights reserved.
//

import Foundation
import PromiseKit

enum RequestType: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

enum CustomAPIError : Error {
    case cannotRetrieveData
    case invalidDataFormat
}

class APIService {
    
    // MARK: Properties
    
    let className = String(typeOfClass: APIService.self)
    
    private static let sharedInstance = {
        return APIService(baseURL: NetworkRes.baseURL_DEV)
    }()
    
    private let baseURL: String
    
    // MARK: Initializers
    
    private init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    // MARK: HTTP Requests
    
    func postIdToken(idToken: String) -> Promise<Any> {
        return sendRequest(endpoint: "/users/idTokens/\(idToken)", type: .POST)
    }
    
    func getUser(uid: String) -> Promise<Any> {
        return sendRequest(endpoint: "/users", type: .GET)
    }
    
    private func sendRequest(endpoint: String, type: RequestType) -> Promise<Any> {
        return Promise { resolve, reject in
            guard let url = URL(string: baseURL + endpoint) else { return }
            var request = URLRequest(url: url)
            request.httpMethod = type.rawValue
            let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                if let error = error {
                    print(self.className + " : " + error.localizedDescription)
                    return reject(error)
                }
                if type == .POST { return resolve(()) }
                guard let data = data, !data.isEmpty else { return reject(CustomAPIError.cannotRetrieveData) }
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) 
                    return resolve(json)
                } catch let error {
                    print(self.className + " : " + error.localizedDescription)
                    return reject(error)
                }
            }
            task.resume()
        }
    }
    
    // MARK: Helper Functions
    
    static func shared() -> APIService {
        return sharedInstance
    }
    
    
}
