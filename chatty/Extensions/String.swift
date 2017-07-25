//
//  String.swift
//  chatty
//
//  Created by Ethan Xue on 2017-07-09.
//  Copyright © 2017 xTech. All rights reserved.
//

import Foundation

extension String {
    
    init(typeOfClass anyClass: AnyClass) {
        self.init(describing: type(of: anyClass))
        self = self.replacingOccurrences(of: ".Type", with: "")
    }
    
    func localized(lang: String? = nil) -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }    
}
