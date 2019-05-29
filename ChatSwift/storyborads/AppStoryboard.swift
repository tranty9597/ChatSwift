//
//  AppStoryboard.swift
//  ChatSwift
//
//  Created by Ty on 5/8/19.
//  Copyright © 2019 Ty. All rights reserved.
//

import UIKit

enum AppStoryborad:  String {
    case Main, Auth, Authencated
    
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T: UIViewController>(viewController: T.Type) -> T {
        let storyboardID = (viewController as UIViewController.Type).storyboardID;
        return instance.instantiateViewController(withIdentifier: storyboardID) as! T
    }
    
    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
    
}


