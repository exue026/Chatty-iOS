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
    
    private let pages = ["Me", "Posts"]
    var pagerBarLeftAnchor: NSLayoutConstraint?
    weak var userProfileController: UserProfileController?
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    private let pagerBar: UIView = {
        let bar = UIView()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.backgroundColor = UIColor.white
        return bar
    }()
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.printInit()
        collectionView.register(ProfilePagerCell.self, forCellWithReuseIdentifier: ProfilePagerCell.cellId)
        
        addSubview(collectionView)
        setupCollectionView()
        
        let indexPathOfDefaultSelectedCell = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: indexPathOfDefaultSelectedCell, animated: false, scrollPosition: [])
        
        addSubview(pagerBar)
        setupPagerBar()
    }
    
    deinit {
        self.printDeinit()
    }
    
    // Public functions
    
    func selectItem(at indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
    }
    
    // UICollectionView
    
    func numberOfSections(in collectionView: UICollectionView) -> Int { return 1 }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return pages.count }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfilePagerCell.cellId, for: indexPath) as! ProfilePagerCell
        cell.setPageName(name: pages[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        userProfileController?.scrollToPagerIndex(index: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { return CGSize(width: frame.width / CGFloat(pages.count), height: frame.height) }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { return 0 }
    
    // Setup Views
    
    private func setupPagerBar() {
        pagerBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1 / CGFloat(pages.count)).isActive = true
        pagerBarLeftAnchor = pagerBar.leftAnchor.constraint(equalTo: self.leftAnchor)
        pagerBarLeftAnchor?.isActive = true
        pagerBar.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        pagerBar.heightAnchor.constraint(equalToConstant: 4).isActive = true
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
    
    // MARK: Properties
    
    static let cellId = "profilePagerCellId"
    
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
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(theme: .bluegrey)
        addSubview(pageName)
        setupPageName()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Public functions
    
    func setPageName(name: String) {
        pageName.text = name
    }
    
    // Setup views
    
    private func setupPageName() {
        pageName.heightAnchor.constraint(equalToConstant: 28).isActive = true
        pageName.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        pageName.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        pageName.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
