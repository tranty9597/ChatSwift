//
//  BrandBar.swift
//  ChatSwift
//
//  Created by Ty on 5/25/19.
//  Copyright © 2019 Ty. All rights reserved.
//

import Foundation

enum BrandBarStatus {
    case brand, search
}

class BrandBar: UIView {
    @IBOutlet var brandView: UIView!
    @IBOutlet var searchView: UIView!
    @IBOutlet weak var searchIcon: CircleImage!
    @IBOutlet weak var messengerIcon: CircleImage!
    @IBOutlet weak var cancelLbl: UILabel!
    
    var mode: BrandBarStatus = .brand
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
}


extension BrandBar {
    func commonInit(){
        Bundle.main.loadNibNamed("BrandBar", owner: self, options: nil)
        
        self.addSubview(brandView)
        brandView.fixInView(self)
        
        let searchGesture = UITapGestureRecognizer(target: self, action: #selector(self.onSearchTap))
        searchIcon.addGestureRecognizer(searchGesture)
        
        
        searchIcon.image.image = UIImage.fontAwesomeIcon(name: .search, style: .solid, textColor: .black, size: CGSize(width: 30, height: 30))
        messengerIcon.image.image = UIImage.fontAwesomeIcon(name: .addressBook, style: .solid, textColor: .white, size: CGSize(width: 30, height: 30))
    }
}
extension BrandBar {
    @objc func onSearchTap(){
        if mode == .brand{
            brandView.removeFromSuperview()
            self.addSubview(searchView)
            searchView.backgroundColor = .red
            
            let cancelGesture = UITapGestureRecognizer(target: self, action: #selector(self.onSearchTap))
            cancelLbl.addGestureRecognizer(cancelGesture)
            
            mode = .search
        }else{
            searchView.removeFromSuperview()
            self.addSubview(brandView)
            brandView.fixInView(self)
            mode = .brand
        }
    }
}
