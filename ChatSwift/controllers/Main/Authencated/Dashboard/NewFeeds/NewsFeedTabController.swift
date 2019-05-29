//
//  NewsFeedTabController.swift
//  ChatSwift
//
//  Created by Ty on 5/12/19.
//  Copyright © 2019 Ty. All rights reserved.
//

import Foundation

class NewsFeedTabController: UIViewController, UICollectionViewDelegate  {
    @IBOutlet weak var newFeedCollection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad();
        
        initComponent()
    }
    
}


extension NewsFeedTabController {
    
    func initComponent() {
        newFeedCollection.showsVerticalScrollIndicator = false
    }
    
}
extension NewsFeedTabController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind ==  UICollectionView.elementKindSectionHeader {
            let headerView = newFeedCollection.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "NewFeedCollectionHeader",
                for: indexPath)
            
            return headerView
        }
        return UICollectionReusableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewFeedCell", for: indexPath)
        return cell
    }
}

extension NewsFeedTabController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width, height: 400)
    }
}
