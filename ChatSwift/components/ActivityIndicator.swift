//
//  ActivityIndicator.swift
//  ChatSwift
//
//  Created by Ty on 5/16/19.
//  Copyright © 2019 Ty. All rights reserved.
//

import UIKit

class ActivityIndicator: UIView {
    
    public static let shared = ActivityIndicator();
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var loadingGif: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

}

extension ActivityIndicator {
    func commonInit() -> Void {
        Bundle.main.loadNibNamed("ActivityIndicator", owner: self, options: nil);
        
        self.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        self.addSubview(contentView);
        
        contentView.fixInView(self)
        contentView.backgroundColor = .clear;
        
        loadingGif.image = UIImage.gifImageWithName("loading")
        
    }
}

extension ActivityIndicator {
    func showIndicator(){
        UIApplication.shared.keyWindow?.addSubview(self);
        self.fixInView(UIApplication.shared.keyWindow)
    }
    func hideIndicator(){
        self.removeFromSuperview();
    }
}
