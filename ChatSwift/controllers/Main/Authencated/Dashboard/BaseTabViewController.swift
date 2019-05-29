//
//  BaseTabController.swift
//  ChatSwift
//
//  Created by Ty on 5/12/19.
//  Copyright © 2019 Ty. All rights reserved.
//

import Foundation


class BaseTabViewController: UIViewController {
    
    @IBOutlet weak var tabBar: UITabBarItem!
    
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
}

extension BaseTabViewController {
    func setTabBehavior(behavior: TabItemBehavior) -> Void{
        self.tabBar.title = behavior.title;
        self.tabBar.image = behavior.inactiveImage;
        self.tabBar.selectedImage = behavior.activeImage
    }
}
