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
    
    private let className = String(typeOfClass: LoadingSpinner.self)
    private let spinner: UIActivityIndicatorView
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        print(className + " : " + "initializing")
        spinner = UIActivityIndicatorView(activityIndicatorStyle: .white)
        super.init(frame: frame)
        
        setupView()
        addSubview(spinner)
        setupSpinner()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print(className + " : deinitializing")
    }
    
    // MARK: Setup views
    
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func setupSpinner() {
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func start() {
        spinner.startAnimating()
    }
    
    func stop() {
        spinner.stopAnimating()
    }
}
