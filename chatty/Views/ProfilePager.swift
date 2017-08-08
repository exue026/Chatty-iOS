//
//  ProfilePager.swift
//  chatty
//
//  Created by Ethan Xue on 2017-08-05.
//  Copyright © 2017 xTech. All rights reserved.
//

import UIKit

class ProfilePager : UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: Properties
    
    private let collectionView: UICollectionView = {
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private let cellId = "cellId"
    private let pageNames = ["Me", "Posts"]
    var pagerBarLeftAnchor: NSLayoutConstraint?
    weak var userProfileController: UserProfileController?
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(ProfilePagerCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        addSubview(collectionView)
        setupCollectionView()
        
        let indexPathOfSelectedCell = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: indexPathOfSelectedCell, animated: false, scrollPosition: [])
        
        setupPagerBar()
    }
    
    // Helper functions
    
    func selectItem(at indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
    }
    
    // UICollectionView
    
    func numberOfSections(in collectionView: UICollectionView) -> Int { return 1 }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return 2 }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProfilePagerCell
        cell.setPageName(name: pageNames[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        userProfileController?.scrollToPagerIndex(index: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { return CGSize(width: frame.width / 2, height: frame.height) }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { return 0 }
    
    // Setup Views
    
    private func setupPagerBar() {
        let bar = UIView()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.backgroundColor = UIColor.white
        addSubview(bar)
        bar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2).isActive = true
        pagerBarLeftAnchor = bar.leftAnchor.constraint(equalTo: self.leftAnchor)
        pagerBarLeftAnchor?.isActive = true
        bar.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        bar.heightAnchor.constraint(equalToConstant: 4).isActive = true
    }
    
    private func setupCollectionView() {
        collectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ProfilePagerCell : UICollectionViewCell {
    
    private let pageName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(14.0)
        label.textColor = UIColor(theme: .dark)
        label.textAlignment = .center
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            pageName.textColor = isSelected ? UIColor.white : UIColor(theme: .dark)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Helper functions
    
    func setPageName(name: String) {
        pageName.text = name
    }
    
    private func setupViews() {
        self.backgroundColor = UIColor(theme: .bluegrey)
        addSubview(pageName)
        setupPageName()
    }
    
    private func setupPageName() {
        pageName.heightAnchor.constraint(equalToConstant: 28).isActive = true
        pageName.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        pageName.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        pageName.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
