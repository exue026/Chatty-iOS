//
//  ContactsController.swift
//  chatty
//
//  Created by Ethan Xue on 2017-08-07.
//  Copyright © 2017 xTech. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ContactsController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "CONTACTS".localized()
        navigationController?.navigationBar.isTranslucent = false
        collectionView!.backgroundColor = UIColor.white
        collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
}
