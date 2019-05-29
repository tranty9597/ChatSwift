//
//  DashboardData.swift
//  ChatSwift
//
//  Created by Ty on 5/11/19.
//  Copyright © 2019 Ty. All rights reserved.
//

import FontAwesome_swift

class DashboardTabItemBehaviors {
    public static let news: TabItemBehavior =  TabItemBehavior.initImageName(title: "News", name: FontAwesome.newspaper, style: FontAwesomeStyle.regular)
    public static let videos: TabItemBehavior = TabItemBehavior.initImageName(title: "Videos", name: FontAwesome.video, style: FontAwesomeStyle.solid)
    public static let store: TabItemBehavior =  TabItemBehavior.initImageName(title: "Store", name: FontAwesome.store, style: FontAwesomeStyle.solid)
    public static let chat: TabItemBehavior =  TabItemBehavior.initImageName(title: "Messages", name: FontAwesome.facebookMessenger)
    public static let menu: TabItemBehavior =  TabItemBehavior.initImageName(title: "Menu", name: FontAwesome.dragon, style: FontAwesomeStyle.solid);
    
    public static let data: [TabItemBehavior] = [news, videos, store, chat, menu];
}

class TabItemBehavior {
    var title: String;
    var activeImage: UIImage;
    var inactiveImage: UIImage
    
    init(title: String, activeImage: UIImage?, inactiveImage: UIImage?) {
        self.title = title;
        self.activeImage = activeImage ?? UIImage();
        self.inactiveImage = activeImage ?? UIImage();
        
    }
    
    static func initImageName(title: String, name: FontAwesome, style: FontAwesomeStyle = FontAwesomeStyle.brands) -> TabItemBehavior{
        
        let activeImg = UIImage.fontAwesomeIcon(name: name, style: style, textColor: UIColor.black, size: CGSize(width: 30, height: 30))
        
        let inActiveImg = UIImage.fontAwesomeIcon(name: name, style: style, textColor: UIColor.white, size: CGSize(width: 25, height: 25))
        
        let ret = TabItemBehavior(title: title, activeImage: activeImg, inactiveImage: inActiveImg);
        return ret;
    }
}
