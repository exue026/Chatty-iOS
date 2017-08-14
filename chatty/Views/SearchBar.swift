//
//  SearchBar.swift
//  chatty
//
//  Created by Ethan Xue on 2017-08-13.
//  Copyright © 2017 xTech. All rights reserved.
//

import UIKit

class SearchBar: UICollectionReusableView {
    
    static let id = "SearchBar"
    
    let bar: UISearchBar = {
        let bar = UISearchBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.barTintColor = UIColor(theme: .purpleblue)
        bar.placeholder = "FIND_FRIENDS".localized()
        bar.autocapitalizationType = .none
        UISearchBar.appearance().tintColor = UIColor.white
        return bar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.printInit()
        self.backgroundColor = UIColor(theme: .purpleblue)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(bar)
        setupBar()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBar() {
        bar.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        bar.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        bar.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
}
