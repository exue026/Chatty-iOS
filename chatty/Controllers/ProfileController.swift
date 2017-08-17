//
//  UserProfile.swift
//  chatty
//
//  Created by Ethan Xue on 2017-08-07.
//  Copyright © 2017 xTech. All rights reserved.
//

import UIKit

class UserProfileController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: Properties
    
    private lazy var profilePager: ProfilePager = {
        let pager = ProfilePager()
        pager.translatesAutoresizingMaskIntoConstraints = false
        pager.userProfileController = self
        return pager
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.printDidLoad()
        
        configureCollectionView()
        navigationItem.title = "PROFILE".localized()
        navigationController?.navigationBar.isTranslucent = false
        
        view.addSubview(profilePager)
        setupProfilePager()
        
        additionalSetup()
    }
    
    deinit {
        self.printDeinit()
    }
    
    // MARK: Helper functions
    
    private func configureCollectionView() {
        if let layout = collectionView!.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        collectionView!.backgroundColor = UIColor.white
        collectionView!.register(ContactProfileView.self, forCellWithReuseIdentifier: ContactProfileView.cellId)
        collectionView!.register(FeedView.self, forCellWithReuseIdentifier: FeedView.cellId)
        collectionView!.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView!.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView!.isPagingEnabled = true
        collectionView!.showsHorizontalScrollIndicator = false
    }
    
    // MARK: Abstract functions
    
    fileprivate func additionalSetup() { }
    
    // MARK: Public functions
    
    func scrollToPagerIndex(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    // MARK: UICollectionView
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return 2 }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContactProfileView.cellId, for: indexPath) as! ContactProfileView
            cell.nameLabel.text = UserManagerService.shared().selectedContact?.displayName
            cell.descriptionLabel.text = UserManagerService.shared().selectedContact?.descript
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedView.cellId, for: indexPath) as! FeedView
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: collectionView.frame.height - collectionView.contentInset.top - 50.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { return 0 }
    
    // MARK: UIScrollView
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        profilePager.pagerBarLeftAnchor?.constant = scrollView.contentOffset.x / CGFloat(2.0)
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pagerIndex = Int(targetContentOffset.move().x / view.frame.width)
        let indexPath = IndexPath(item: pagerIndex, section: 0)
        profilePager.selectItem(at: indexPath)
    }
    
    // MARK: Setup views
    
    private func setupProfilePager() {
        profilePager.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        profilePager.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        profilePager.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profilePager.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

class MyUserProfileController: UserProfileController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if UserManagerService.shared().updatedInfo {
            collectionView!.reloadData()
            UserManagerService.shared().updatedInfo = false
        }
    }
    
    override func additionalSetup() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "SETTINGS".localized(), style: .plain, target: self, action: #selector(segueToProfileSettings))
        collectionView!.register(ProfileView.self, forCellWithReuseIdentifier: ProfileView.cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileView.cellId, for: indexPath) as! ProfileView
            cell.nameLabel.text = UserManagerService.shared().myUser?.displayName
            cell.descriptionLabel.text = UserManagerService.shared().myUser?.descript
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedView.cellId, for: indexPath) as! FeedView
            return cell
        }
    }
    
    // MARK: Navigation
    
    @objc private func segueToProfileSettings() {
        navigationController?.pushViewController(ProfileSettingsController(), animated: true)
    }
}

