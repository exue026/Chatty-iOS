//
//  FirebaseService.swift
//  chatty
//
//  Created by Ethan Xue on 2017-07-13.
//  Copyright © 2017 xTech. All rights reserved.
//

import Foundation
import Firebase
import PromiseKit

enum CustomFirebaseError : Error {
    case emailNotVerified
    case blankFields
    case unknownError
}

class FirebaseService {
    
    // MARK: Properties

    let className = String(typeOfClass: FirebaseService.self)
    
    private static let sharedInstance = {
        return FirebaseService(databaseURL: FirebaseRes.databaseURL)
    }()
    
    private let databaseRef: FIRDatabaseReference
    
    // MARK: Initializers
    
    private init(databaseURL: String) {
        databaseRef = FIRDatabase.database().reference(fromURL: databaseURL).child(FirebaseRes.main_dir)
    }
    
    // MARK: Authentication
    
    func createUser(username: String, email: String, password: String, handler: @escaping (Error?) -> Void) {
        if username.trim().isEmpty || email.trim().isEmpty || password.trim().isEmpty {
            handler(CustomFirebaseError.blankFields)
        }
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user: FIRUser?, error1: Error?) in
            if let error = error1 {
                handler(error)
                return
            }
            user?.sendEmailVerification { (error2: Error?) in
                if let error = error2 {
                    handler(error)
                    return
                }
                guard let uid = user?.uid else { return }
                let usersRef = self.databaseRef.child(uid)
                let values = ["username": username, "email": email, "password": password]
                usersRef.updateChildValues(values, withCompletionBlock: { (error3: Error?, _) in
                    if let error = error3 {
                        print(self.className + " : " + error.localizedDescription)
                    }
                })
                handler(nil)
            }
        }
    }
    
    func signInUser(email: String, password: String) -> Promise<Void> {
        return Promise { resolve, reject in
            if email.trim().isEmpty || password.trim().isEmpty { return reject(CustomFirebaseError.blankFields) }
            FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user: FIRUser?, error: Error?) in
                if let error = error { return reject(error) }
                guard let user = user else { return reject(CustomFirebaseError.unknownError) }
                if !user.isEmailVerified {
                    do {
                        try FIRAuth.auth()?.signOut()
                        return reject(CustomFirebaseError.emailNotVerified)
                    }
                    catch let error {
                        print(self.className + " : " + error.localizedDescription)
                        return reject(error)
                    }
                }
                user.getTokenForcingRefresh(true) { (idToken: String?, error: Error?) in
                    guard let idToken = idToken else { return reject(CustomFirebaseError.unknownError) }
                    APIService.shared().postIdToken(idToken: idToken).then { _ in
                        return resolve(())
                    }.catch { (error: Error) in
                        return reject(error)
                    }
                }
            }
        }
    }
    
    func logoutCurrentUser() -> Bool {
        do {
            try FIRAuth.auth()?.signOut()
        }
        catch let error {
            print(error)
            return false
        }
        return true
    }
    
    func hasCurrentUser() -> Bool {
        return FIRAuth.auth()?.currentUser != nil ? true : false
    }
    
    // MARK: Helper Functions
    
    static func shared() -> FirebaseService {
        return sharedInstance
    }
    
}
