//
//  FeedController.swift
//  chatty
//
//  Created by Ethan Xue on 2017-07-30.
//  Copyright © 2017 xTech. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class FeedController: UICollectionViewController {
    
    // MARK: Properties
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.printDidLoad()
        collectionView!.backgroundColor = UIColor.white
        
        navigationItem.title = "NEWSFEED".localized()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "POST".localized(), style: .plain, target: self, action: #selector(handlePost))
        navigationController?.navigationBar.isTranslucent = false
        
        collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    deinit {
        self.printDeinit()
    }
    
    // MARK: Post button target
    
    @objc private func handlePost() {
        
    }
    
    // MARK: UICollectionView

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        return cell
    }

}
