//
//  UIColor.swift
//  chatty
//
//  Created by Ethan Xue on 2017-07-09.
//  Copyright © 2017 xTech. All rights reserved.
//

import UIKit

enum ThemeColour {
    case purpleblue
    case blue
    case indigo
    case thistle
    case grey
}

extension UIColor {
    
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat, opacity: CGFloat) {
        self.init(red: red/255, green: green/255 , blue: blue/255 , alpha: opacity)
    }
    
    convenience init(theme: ThemeColour, opacity: CGFloat? = 1.0) {
        switch (theme) {
        case .purpleblue:
            self.init(red: 41/255, green: 12/255, blue: 90/225, alpha: opacity!)
        case .blue:
            self.init(red: 61/255, green: 91/255, blue: 151/255, alpha: opacity!)
        case .indigo:
            self.init(red: 75/255, green: 0, blue: 130/255, alpha: opacity!)
        case .thistle:
            self.init(red: 216/255, green: 191/255, blue: 216/255, alpha: opacity!)
        default:
            self.init(red: 112/255, green: 128/255, blue: 144/255, alpha: opacity!)
        }
    }
    
}

