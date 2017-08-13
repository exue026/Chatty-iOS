//
//  NSObject.swift
//  chatty
//
//  Created by Ethan Xue on 2017-08-08.
//  Copyright © 2017 xTech. All rights reserved.
//

import Foundation

extension NSObject {
    
    var className: String {
        var name = String(describing: type(of: self))
        name = name.replacingOccurrences(of: ".Type", with: "")
        return name
    }
    
    func printInit() {
        print(className + " : Initializing")
    }
    
    func printDeinit() {
        print(className + " : Deinitializing")
    }
    
    func printDidLoad() {
        print(className + " : didLoad")
    }
    
}
