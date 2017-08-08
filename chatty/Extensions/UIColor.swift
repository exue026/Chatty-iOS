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
    case dark
    case thistle
    case light_purple
    case bluegrey
    case mint
    case grey
}

extension UIColor {
    
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat, opacity: CGFloat) {
        self.init(red: red/255, green: green/255 , blue: blue/255 , alpha: opacity)
    }
    
    convenience init(theme: ThemeColour, opacity: CGFloat = 1.0) {
        switch (theme) {
        case .purpleblue:
            self.init(red: 41/255, green: 12/255, blue: 90/225, alpha: opacity)
        case .dark:
            self.init(red: 26/255, green: 25/255, blue: 50/255, alpha: opacity)
        case .thistle:
            self.init(red: 216/255, green: 191/255, blue: 216/255, alpha: opacity)
        case .light_purple:
            self.init(red: 171/255, green: 71/255, blue: 188/255, alpha: opacity)
        case .bluegrey:
            self.init(red: 84/255, green: 110/255, blue: 125/255, alpha: opacity)
            
        case .mint:
            self.init(red: 175/255, green: 210/255, blue: 200/255, alpha: opacity)
        case .grey:
            self.init(red: 112/255, green: 128/255, blue: 144/255, alpha: opacity)
        }
    }
    
}

