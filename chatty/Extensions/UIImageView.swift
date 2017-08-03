//
//  UIImage.swift
//  chatty
//
//  Created by Ethan Xue on 2017-08-01.
//  Copyright © 2017 xTech. All rights reserved.
//

import UIKit

extension UIImageView {
    func makeRounded() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.borderWidth = 1.0
    }
}
