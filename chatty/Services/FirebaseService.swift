//
//  FirebaseService.swift
//  chatty
//
//  Created by Ethan Xue on 2017-07-13.
//  Copyright © 2017 xTech. All rights reserved.
//

import Foundation
import Firebase

enum CustomFirebaseError : Error {
    case emailNotVerified
    case blankFields
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
        if username.trim() == "" || email.trim() == "" || password.trim() == "" {
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
    
    func signInUser(email: String, password: String, handler: @escaping (Error?) -> Void) {
        if email.trim() == "" || password.trim() == "" {
            handler(CustomFirebaseError.blankFields)
        }
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user: FIRUser?, error1: Error?) in
            if let error = error1 {
                handler(error)
                return
            }
            let user = user!
            if user.isEmailVerified != true {
                do {
                    try FIRAuth.auth()?.signOut()
                }
                catch let error2 {
                    print(self.className + " : " + error2.localizedDescription)
                }
                handler(CustomFirebaseError.emailNotVerified)
                return
            }
            APIService.shared().postUid(uid: user.uid, handler: { (error3: Error?) in
                if error3 != nil {
                    return
                }
                handler(nil)
            })
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
    
    func checkPersistentUserSession(handler: @escaping (Bool) -> Void) {
        FIRAuth.auth()?.currentUser != nil ? handler(true) : handler(false)
    }
    
    // MARK: Helper Functions
    
    static func shared() -> FirebaseService {
        return sharedInstance
    }
    
}
