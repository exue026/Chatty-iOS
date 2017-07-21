//
//  APIService.swift
//  chatty
//
//  Created by Ethan Xue on 2017-07-12.
//  Copyright © 2017 xTech. All rights reserved.
//

import Foundation

enum RequestType: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
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
    
    func postUid(uid: String, handler: @escaping (Error?) -> Void) {
        sendRequest(endpoint: "/users/uids/\(uid)", type: .POST, handler: handler)
    }
    
    func getUser(uid: String, handler: @escaping (Error?) -> Void) {
        sendRequest(endpoint: "/users", type: .GET, handler: handler)
    }
    
    private func sendRequest(endpoint: String, type: RequestType, handler: @escaping (Error?) -> Void) {
        guard let url = URL(string: baseURL + endpoint) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = type.rawValue
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                print(self.className + " : " + error.localizedDescription)
                handler(error)
                return
            }
            guard let data = data, !data.isEmpty else {
                handler(nil)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                print(json)
                handler(nil)
            } catch let error {
                print(self.className + " : " + error.localizedDescription)
                handler(error)
            }
        }
        task.resume()
    }
    
    // MARK: Helper Functions
    
    static func shared() -> APIService {
        return sharedInstance
    }
}
