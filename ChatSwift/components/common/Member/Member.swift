//
//  Member.swift
//  ChatSwift
//
//  Created by Ty on 5/21/19.
//  Copyright © 2019 Ty. All rights reserved.
//

import Foundation
import UIKit

class Member: UIView {
    
    var mainStackView = UIStackView();
    
    var avatarContainer = UIView();
    var avatar = UIImageView();
    
    var infoStackView = UIStackView();
    
    var nameStack = UIStackView();
    var nameLabel = UILabel();
    
    var extraData = UIView();
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initComponent()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
}

extension Member {
    func initComponent() {
        
        self.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.fixInView(self)
        mainStackView.axis = .horizontal
        
        avatarContainer.addSubview(avatar);
        avatarContainer.setWidth(width: 60)
        
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.image = UIImage.fontAwesomeIcon(name: .facebook, style: .brands, textColor: .black, size: CGSize(width: 45, height: 45))
        avatarContainer.setCenterSubview(subView: avatar)
        
        nameStack.addArrangedSubview(nameLabel)
        nameLabel.text = "Mark Jocuerbus"
        
        infoStackView.addArrangedSubview(nameStack)
        infoStackView.addArrangedSubview(extraData)

        mainStackView.addArrangedSubview(avatarContainer)
        mainStackView.addArrangedSubview(infoStackView)
    }
}
extension UIStackView {
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}
