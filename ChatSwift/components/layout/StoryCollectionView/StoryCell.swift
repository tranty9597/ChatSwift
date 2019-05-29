//
//  StoryCell.swift
//  ChatSwift
//
//  Created by Ty on 5/16/19.
//  Copyright © 2019 Ty. All rights reserved.
//

import Foundation


class StoryCell: UICollectionViewCell {
    
    @IBOutlet var contentCel: UIView!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
}
extension StoryCell {
    func commonInit() {
        Bundle.main.loadNibNamed("StoryCell", owner: self, options: nil);
        self.addSubview(contentCel)
        contentCel.fixInView(self)
    }
    
    func initLayout () {
        bgImage.layer.masksToBounds = true;
        bgImage.layer.cornerRadius = 8;
        
        avatar.setGradientBorder(width: 1, colors: [.blue, .green])
        avatar.clipsToBounds = true
        avatar.layer.masksToBounds = true
        avatar.layer.cornerRadius = 27.5
    }
}
