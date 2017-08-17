//
//  PostCell.swift
//  chatty
//
//  Created by Ethan Xue on 2017-08-14.
//  Copyright © 2017 xTech. All rights reserved.
//

import UIKit

class PostCell: UICollectionViewCell {
    
    static let cellId = "PostCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.lightGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.printDeinit()
    }
}
