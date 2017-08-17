//
//  ContactsController.swift
//  chatty
//
//  Created by Ethan Xue on 2017-08-07.
//  Copyright © 2017 xTech. All rights reserved.
//

import UIKit

class ContactsController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    // MARK: Properties
    
    private lazy var spinner = LoadingSpinner(frame: CGRect.zero)
    
    private var contacts: [User]? = {
        return UserManagerService.shared().contacts
    }()
    
    private var didQuery: Bool = false
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "CONTACTS".localized()
        navigationController?.navigationBar.isTranslucent = false
        
        collectionView!.backgroundColor = UIColor(theme: .bluegrey)
        collectionView!.register(ContactCell.self, forCellWithReuseIdentifier: ContactCell.cellId)
        collectionView!.register(SearchBar.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: SearchBar.id)
        collectionView!.scrollIndicatorInsets = UIEdgeInsetsMake(40.0, 0.0, 0.0, 0.0)
        
        view.addSubview(spinner)
        setupSpinner()
    }
    
    // MARK: UICollectionView
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let numContacts = contacts?.count {
            return numContacts
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContactCell.cellId, for: indexPath) as! ContactCell
        if let username = contacts?[indexPath.row].username, let name = contacts?[indexPath.row].displayName {
            cell.usernameLabel.text = username
            cell.nameLabel.text = name
        }
        else {
            cell.usernameLabel.text = "FRIEND".localized()
            cell.nameLabel.text = "FRIEND".localized()
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UserManagerService.shared().selectedContact = contacts?[indexPath.row]
        navigationController?.pushViewController(UserProfileController(collectionViewLayout: UICollectionViewFlowLayout()), animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 60.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 40.0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SearchBar.id, for: indexPath) as!
                SearchBar
        header.bar.delegate = self
        return header
    }
    
    // MARK: UISearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        spinner.start()
        searchBar.endEditing(true)
        searchBar.subviews.forEach { $0.subviews.forEach { if let button = $0 as? UIButton { button.isEnabled = true }}}
        APIService.shared().getMatchingUsers(forUsername: text.trim()).then { (users: [User]?) -> Void in
            if let users = users {
                self.contacts = users
                self.didQuery = true
                self.collectionView!.reloadData()
            }
        }.catch { error in
            print(error.localizedDescription)
        }.always {
            self.spinner.stop()
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.text = ""
        if didQuery {
            didQuery = false
            contacts = UserManagerService.shared().contacts
            collectionView!.reloadData()
        }
    }
    
    // MARK: Setup views
    
    private func setupSpinner() {
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
