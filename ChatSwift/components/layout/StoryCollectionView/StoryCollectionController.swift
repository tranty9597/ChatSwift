//
//  StoryCollectionView.swift
//  ChatSwift
//
//  Created by Ty on 5/16/19.
//  Copyright © 2019 Ty. All rights reserved.
//

import Foundation

class StoryCollectionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var collectionLayout: UICollectionViewFlowLayout!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
}

extension StoryCollectionView {
    func commonInit() {
        
        Bundle.main.loadNibNamed("StoryCollectionView", owner: self, options: nil)
        
        self.addSubview(contentView);
        contentView.fixInView(self)
        
        collectionView.register(StoryCell.self, forCellWithReuseIdentifier: "StoryCell")
        
        self.setCollectionLayout()
    }
}

extension StoryCollectionView {

    func setCollectionLayout() {
        
        let itemWidth = self.frame.size.width * 0.4
        let itemHeight = self.frame.size.height - 60
        
        collectionLayout = UICollectionViewFlowLayout();
        
        collectionLayout.scrollDirection = .horizontal
        collectionLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        collectionView.collectionViewLayout = collectionLayout;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCell", for: indexPath) as! StoryCell;
        cell.contentCel.showAnimatedSkeleton()
        
        let url = URL(string: "https://picsum.photos/id/5/200/300")
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            if data != nil {
                DispatchQueue.main.async {
                    cell.bgImage.image = UIImage(data: data!);
                    cell.contentCel.hideSkeleton()
                }
            }
        }
        
        cell.avatar.image = UIImage.fontAwesomeIcon(name: .github, style: .brands, textColor: .white, size: CGSize(width: 55, height: 55))
        
        cell.name.text = "John Whitch"

        return cell;
    }

}
