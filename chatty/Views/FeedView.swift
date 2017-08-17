//
//  FeedView.swift
//  chatty
//
//  Created by Ethan Xue on 2017-08-14.
//  Copyright © 2017 xTech. All rights reserved.
//

import UIKit

class FeedView: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    static let cellId = "FeedView"
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PostCell.self, forCellWithReuseIdentifier: PostCell.cellId)
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.printInit()
        self.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(collectionView)
        setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.printDeinit()
    }
    
    fileprivate func additionalSetup() { }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCell.cellId, for: indexPath) as! PostCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: 75.0)
    }
    
    private func setupCollectionView() {
        collectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
}
