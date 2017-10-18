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
    var userId: Int?
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PostCell.self, forCellWithReuseIdentifier: PostCell.cellId)
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.printInit()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.white
        
        addSubview(collectionView)
        setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.printDeinit()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let id = userId {
            return UserManagerService.shared().posts?.filter { $0.postedByUserWithId == id}.count ?? 0
        }
        return UserManagerService.shared().posts?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCell.cellId, for: indexPath) as! PostCell
        if let id = userId {
            if let posts = UserManagerService.shared().posts?.filter({ $0.postedByUserWithId == id}) {
                cell.dateLabel.text = posts[indexPath.row].timeSinceNow
                cell.headLabel.text = posts[indexPath.row].title
                cell.bodyLabel.text = posts[indexPath.row].text
            }
            return cell
        } else {
            if let post = UserManagerService.shared().posts?[indexPath.row] {
                cell.dateLabel.text = post.timeSinceNow
                cell.headLabel.text = post.title
                cell.bodyLabel.text = post.text
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let body = UserManagerService.shared().posts?[indexPath.row].text {
            let rect = NSString(string: body).boundingRect(with: CGSize(width: self.frame.width, height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14.0)], context: nil)
            return CGSize(width: self.frame.width, height: rect.height + 30 + 6 + 40 + 30 + 6 + 12)
        }
        
        return CGSize(width: self.frame.width, height: 150)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("scrolling!!")
    }
    
    private func setupCollectionView() {
        collectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
}
