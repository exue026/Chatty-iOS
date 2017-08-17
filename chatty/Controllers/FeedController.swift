//
//  FeedController.swift
//  chatty
//
//  Created by Ethan Xue on 2017-07-30.
//  Copyright © 2017 xTech. All rights reserved.
//

import UIKit

class FeedController: UICollectionViewController {
    
    // MARK: Properties
    
    private var feedView: FeedView?
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.printDidLoad()
        navigationItem.title = "NEWSFEED".localized()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "POST".localized(), style: .plain, target: self, action: #selector(handlePost))
        navigationController?.navigationBar.isTranslucent = false
        feedView = FeedView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - 65))
        view.addSubview(feedView!)
        setupFeedView()
    }
    
    deinit {
        self.printDeinit()
    }
    
    // MARK: Post button target
    
    @objc private func handlePost() {
        
    }
    
    // MARK: Properties
    
    private func setupFeedView() {
        feedView?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        feedView?.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        feedView?.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
}
