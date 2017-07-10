//
//  String.swift
//  chatty
//
//  Created by Ethan Xue on 2017-07-09.
//  Copyright © 2017 xTech. All rights reserved.
//

import Foundation

extension String {
    
    func localized(lang: String? = nil) -> String {
        return NSLocalizedString(self, comment: "")
    }
    
}
