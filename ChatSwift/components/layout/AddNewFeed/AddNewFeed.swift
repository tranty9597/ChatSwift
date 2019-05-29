//
//  AddNewFeed.swift
//  ChatSwift
//
//  Created by Ty on 5/21/19.
//  Copyright © 2019 Ty. All rights reserved.
//

import Foundation
import FontAwesome_swift

class AddNewFeed: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var btnContainer: UIStackView!
    
    var liveStreamBtn = AppButton()
    var imageBtn = AppButton()
    var checkinBtn = AppButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
}
extension AddNewFeed {
    func commonInit() {
        Bundle.main.loadNibNamed("AddNewFeed", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.fixInView(self)
        
        btnContainer.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
        initButtons(button: liveStreamBtn, title: "Live stream", iconName: .videoSlash)
        initButtons(button: imageBtn, title: "Image", iconName: .image)
        initButtons(button: checkinBtn, title: "Check in", iconName: .check)
        
    }
    
    func initButtons(button: AppButton, title: String, iconName: FontAwesome){
        btnContainer.addArrangedSubview(button)
        
        button.initWithChildren(children: [.leftIcon, .label])
        button.label.text = title
        button.leftIcon.image = UIImage.fontAwesomeIcon(name: iconName, style: .solid, textColor: .black, size: CGSize(width: 25, height: 25))
    }
}
