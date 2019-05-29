//
//  UIViewControllerWithExtension.swift
//  ChatSwift
//
//  Created by Ty on 5/8/19.
//  Copyright © 2019 Ty. All rights reserved.
//

import UIKit

class UIViewControllerWithExtension: UIViewController {
    
}

extension UIViewController {
    class var storyboardID : String {
        return "\(self)"
    }
    
    static func instantiateFromAppStoryboard(storyboard: AppStoryborad) -> Self {
        return storyboard.viewController(viewController: self);
    }
    
    func setDefaultBackgroundNavigationBar(){
        if let navigationBar = self.navigationController?.navigationBar {
            let gradient = CAGradientLayer()
            var bounds = navigationBar.bounds
            bounds.size.height += UIApplication.shared.statusBarFrame.size.height
            gradient.frame = bounds
            gradient.colors = [UIColor(argb: 0xFF40e0d0), UIColor(argb: 0xFF98fb98)]
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 1, y: 0)
            
            if let image = UIImage.getImageFrom(gradientLayer: gradient) {
                navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
            }
        }
    }
}
