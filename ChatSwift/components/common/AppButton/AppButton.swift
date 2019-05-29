//
//  AppButton.swift
//  ChatSwift
//
//  Created by Ty on 5/21/19.
//  Copyright © 2019 Ty. All rights reserved.
//

import Foundation


enum AppButtonChild {
    case leftIcon, rightIcon, label
}


class AppButton: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var stackView: UIStackView!

    var leftIcon: UIImageView!
    var label: UILabel!
    var rightIcon: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    func initWithChildren(children: [AppButtonChild]) {
        children.forEach { (child) in
            switch (child) {
            case .leftIcon:
                leftIcon = UIImageView()
                leftIcon.setSize(width: 25, height: 25)
                
                stackView.addArrangedSubview(leftIcon)
                break
            case .rightIcon:
                rightIcon = UIImageView()
                rightIcon.setSize(width: 25, height: 25)
                
                stackView.addArrangedSubview(rightIcon)
                break
            case .label:
                label = UILabel()
                stackView.addArrangedSubview(label)
                break
            }
        }
    }
    
}

extension AppButton {
    func commonInit(){
        Bundle.main.loadNibNamed("AppButton", owner: self, options: nil)
        
        self.addSubview(contentView)
        contentView.fixInView(self)
    }
    
}
