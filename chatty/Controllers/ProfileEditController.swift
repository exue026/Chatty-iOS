//
//  ProfileEditController.swift
//  chatty
//
//  Created by Ethan Xue on 2017-08-01.
//  Copyright © 2017 xTech. All rights reserved.
//

import UIKit

protocol DataReceiver {
    func getData(data: AnyHashable)
}

class ProfileEditController: UIViewController, DataReceiver {
    
    // MARK: Properties
    
    private let className = String(typeOfClass: ProfileEditController.self)
    
    private var data: String?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(className  + " : didLoad")
        view.backgroundColor = UIColor.white
        
        navigationItem.title = data
    }
    
    deinit {
        print(className + " : deinitializing")
    }
    
    // MARK: DataReceiver
    
    func getData(data: AnyHashable) {
        self.data = data as? String
    }
}
