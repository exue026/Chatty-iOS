//
//  UserProfileController.swift
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
        configureNavBar()
        
        view.addSubview(profilePager)
        setupProfilePager()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if UserManagerService.shared().updatedInfo {
            UserManagerService.shared().updatedInfo = false
            let profilePageIndexPath = IndexPath(item: 0, section: 0)
            let cell = collectionView?.cellForItem(at: profilePageIndexPath) as? ProfileCell
            cell?.nameLabel.text = UserManagerService.shared().myUser?.displayName
            cell?.descriptionLabel.text = UserManagerService.shared().myUser?.descript
            collectionView!.reloadData()
        }
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
        collectionView!.register(ProfileCell.self, forCellWithReuseIdentifier: ProfileCell.cellId)
        collectionView!.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView!.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView!.isPagingEnabled = true
        collectionView!.showsHorizontalScrollIndicator = false
    }
    
    private func configureNavBar() {
        navigationItem.title = "PROFILE".localized()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "SETTINGS".localized(), style: .plain, target: self, action: #selector(segueToProfileSettings))
        navigationController?.navigationBar.isTranslucent = false
    }
    
    // Public functions
    
    func scrollToPagerIndex(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    // MARK: UICollectionView
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int { return 1 }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return 2 }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCell.cellId, for: indexPath) as! ProfileCell
        return cell
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
    
    // MARK: Navigation
    
    @objc private func segueToProfileSettings() {
        navigationController?.pushViewController(ProfileSettingsController(), animated: true)
    }
    
    // MARK: Setup views
    
    private func setupProfilePager() {
        profilePager.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        profilePager.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        profilePager.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profilePager.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
