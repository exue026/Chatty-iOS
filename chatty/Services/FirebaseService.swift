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
    
    private static let sharedInstance = {
        return FirebaseService(databaseURL: FirebaseRes.databaseURL)
    }()
    
    private let databaseRef: FIRDatabaseReference
    
    // MARK: Initializers
    
    private init(databaseURL: String) {
        databaseRef = FIRDatabase.database().reference(fromURL: databaseURL).child(FirebaseRes.main_dir)
    }
    
    // MARK: Authentication
    
    func createUser(username: String, email: String, password: String) -> Promise<Void> {
        return Promise { resolve, reject in
            if username.trim().isEmpty || email.trim().isEmpty || password.trim().isEmpty { return reject(CustomFirebaseError.blankFields) }
            FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user: FIRUser?, error: Error?) in
                if let error = error { return reject(error) }
                user?.sendEmailVerification { (error: Error?) in
                    if let error = error { return reject(error) }
                    guard let uid = user?.uid else { return }
                    let usersRef = self.databaseRef.child(uid)
                    let values = ["username": username, "email": email, "password": password]
                    usersRef.updateChildValues(values, withCompletionBlock: { (error: Error?, _) in
                        if let error = error {
                            print(error.localizedDescription)
                            return reject(CustomFirebaseError.unknownError)
                        }
                        return resolve(())
                    })
                }
            }
        }
    }
    
    func signInUser(email: String, password: String) -> Promise<String> {
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
                        print(error.localizedDescription)
                        return reject(error)
                    }
                }
                user.getTokenForcingRefresh(true) { (idToken: String?, error: Error?) in
                    guard let idToken = idToken else { return reject(CustomFirebaseError.unknownError) }
                    return resolve(idToken)
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
        UserManagerService.shared().myUser = nil
        return true
    }
    
    func currentUserExists() -> Bool {
        return FIRAuth.auth()?.currentUser != nil ? true : false
    }
    
    // MARK: Helper Functions
    
    static func shared() -> FirebaseService {
        return sharedInstance
    }
    
}
