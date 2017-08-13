//
//  LoadingSpinner.swift
//  chatty
//
//  Created by Ethan Xue on 2017-07-27.
//  Copyright © 2017 xTech. All rights reserved.
//

import UIKit

class LoadingSpinner: UIView {
    
    // MARK: Properties
    
    private let spinner: UIActivityIndicatorView
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        spinner = UIActivityIndicatorView(activityIndicatorStyle: .white)
        super.init(frame: frame)
        self.printInit()
        self.isHidden = true
        
        setupView()
        addSubview(spinner)
        setupSpinner()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.printDeinit()
    }
    
    // MARK: Setup views
    
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.widthAnchor.constraint(equalToConstant: 90).isActive = true
        self.heightAnchor.constraint(equalToConstant: 90).isActive = true
    }
    
    private func setupSpinner() {
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.transform = CGAffineTransform(scaleX: 1.6, y: 1.6)
        spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    // MARK: Public functions
    
    func start() {
        self.isHidden = false
        spinner.startAnimating()
    }
    
    func stop() {
        spinner.stopAnimating()
        self.isHidden = true
    }
}
