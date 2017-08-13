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
    
    private static let sharedInstance = {
        return APIService(baseURL: NetworkRes.baseURL_DEV)
    }()
    
    private let baseURL: String
    
    // MARK: Initializers
    
    private init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    // MARK: HTTP Requests
    
    func getUser(forIdToken idToken: String) -> Promise<User> {
        return firstly {
            sendRequest(endpoint: "/users/idTokens/\(idToken)", type: .GET)
        }.then { (data: Data?) -> Promise<User> in
            do {
                let user = try JSONDecoder().decode(User.self, from: data!)
                return Promise(value: user)
            } catch let error {
                print(error.localizedDescription)
                throw error
            }
        }
    }
    
    func updateUser(forId id: Int, info: [String: Any]) -> Promise<Data?> {
        return sendRequest(endpoint: "/users/\(id)/updateInfo", type: .PUT, body: info)
    }
    
    private func sendRequest(endpoint: String, type: RequestType, body: [String: Any]? = nil) -> Promise<Data?> {
        return Promise { resolve, reject in
            guard let url = URL(string: baseURL + endpoint) else { return }
            var request = URLRequest(url: url)
            request.httpMethod = type.rawValue
            if let body = body {
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            }
            let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                if let error = error {
                    print(error.localizedDescription)
                    return reject(error)
                }
                if type == .PUT || type == .POST { return resolve(nil) }
                guard let data = data, !data.isEmpty else { return reject(CustomAPIError.cannotRetrieveData) }
                resolve(data)
            }
            task.resume()
        }
    }
    
    // MARK: Helper Functions
    
    static func shared() -> APIService {
        return sharedInstance
    }
}
