//
//  DashboardController.swift
//  ChatSwift
//
//  Created by Ty on 5/11/19.
//  Copyright © 2019 Ty. All rights reserved.
//

import Foundation
import UIKit;

import UserNotifications

class DashboardController: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setAppearnaceForAllTab();
        self.setDefaultBackgroundNavigationBar()
        
        UNUserNotificationCenter.current().delegate = self
        
        AppTwilioChatClient.shared.fetchAccessToken { (toekn) in
            
        }
    }
}


extension DashboardController {
    
    func setAppearnaceForAllTab() -> Void {
        
        var index = 0;
        
        self.tabBar.items?.forEach({ (tabItem) in
            setAppearanceForTabItem(tabItem: tabItem, data: DashboardTabItemBehaviors.data[index])
            
            index += 1;
        })
        
    }
    
    func setAppearanceForTabItem(tabItem: UITabBarItem, data: TabItemBehavior) -> Void {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.darkGray], for: .normal)
        
        tabItem.title = data.title;
        tabItem.image = data.inactiveImage;
        tabItem.selectedImage = data.activeImage;
    }
}

extension DashboardController: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
    }
    
    
}
