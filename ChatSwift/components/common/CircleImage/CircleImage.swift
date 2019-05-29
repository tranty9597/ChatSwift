//
//  CircleImage.swift
//  ChatSwift
//
//  Created by Ty on 5/25/19.
//  Copyright © 2019 Ty. All rights reserved.
//

import Foundation

class CircleImage: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var image: UIImageView!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
}

extension CircleImage {
    func commonInit(){
        Bundle.main.loadNibNamed("CircleImage", owner: self, options: nil)
        
        self.addSubview(contentView)
        contentView.fixInView(self)
        
        contentView.backgroundColor = .clear
        self.layer.masksToBounds = true;
        self.layer.cornerRadius = self.frame.size.height * 0.5
    }
}
