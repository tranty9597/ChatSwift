//
//  NewFeed.swift
//  ChatSwift
//
//  Created by Ty on 5/21/19.
//  Copyright © 2019 Ty. All rights reserved.
//

import Foundation
import FontAwesome_swift

class NewFeed: UICollectionViewCell {
    
    @IBOutlet var cellContent: UIView!
    @IBOutlet weak var contentStack: UIStackView!
    
    var controlBtns = UIStackView()
    var likeBtn = AppButton()
    var commentBtn = AppButton()
    var shareBtn = AppButton()
    
    var contentTxt = UILabel()
    var imageContainer = UIView();
    var imageStack = UIStackView()
    
    let testImgs = ["https://images.pexels.com/photos/414612/pexels-photo-414612.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRBu7qUznng_t9q5wEkW4obHtb-lbgqXpU0y4Gu77Su30QteHK", "https://data.whicdn.com/images/329858934/original.jpg?t=1556728606"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
}

extension NewFeed {
    func commonInit(){
        Bundle.main.loadNibNamed("NewFeed", owner: self, options: nil)
        
        self.addSubview(cellContent)
        cellContent.fixInView(self)
        
        contentTxt.numberOfLines = 0;
        contentTxt.lineBreakMode = .byWordWrapping
//        contentTxt.frame.size.width = self.frame.size.width - 30
        contentTxt.sizeToFit()
        contentTxt.text = "Thầy gửi Individual Assignment 1. Các em điền đầy đủ thông tin vào trong, bài, làm trên bản word và sau đó gửi lại cho Doan Tu rồi Tú nén lại gửi vào email cho Thầy. Deadline: 23h ngày 21/05/2019"
        contentStack.addArrangedSubview(contentTxt)
        contentStack.addArrangedSubview(imageStack)
        contentStack.addArrangedSubview(controlBtns)
        
        contentStack.distribution = .equalCentering
        contentStack.spacing = 0
        
        imageStack.setHeight(height: 100)
        
        imageStack.addBackground(color: .blue)
        imageStack.axis = .horizontal
        imageStack.distribution = .equalSpacing
        
        imageStack.alignment = .center
        var index = 1;
        DispatchQueue.global().async {
            self.testImgs.forEach({ (url) in
//                let uri = URL(string: url)
//                let data = try? Data(contentsOf: uri!)
                
                DispatchQueue.main.async {
                    let image = UIImageView()
                    image.image = UIImage.fontAwesomeIcon(name: .github, style: .brands, textColor: .white, size: CGSize(width: 120, height: 120))
                    
                    image.translatesAutoresizingMaskIntoConstraints = false;
                    
                    image.backgroundColor = index % 2 == 0 ? .red : .blue
                    index += 1
                    
                    self.imageStack.addArrangedSubview(image)

                }
            })
        }
        
       
        controlBtns.setHeight(height: 32)
        controlBtns.distribution = .equalSpacing
        controlBtns.addBackground(color: .red)
        
        initButtons(button: likeBtn, title: "Like", iconName: .heart)
        initButtons(button: commentBtn, title: "Comment", iconName: .comment)
        initButtons(button: shareBtn, title: "Share", iconName: .share)
    }
    func initButtons(button: AppButton, title: String, iconName: FontAwesome){
        controlBtns.addArrangedSubview(button)
        
        button.initWithChildren(children: [.leftIcon, .label])
        button.label.text = title
        button.leftIcon.image = UIImage.fontAwesomeIcon(name: iconName, style: .solid, textColor: .black, size: CGSize(width: 25, height: 25))
    }
}
