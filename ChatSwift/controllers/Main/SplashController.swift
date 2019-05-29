//
//  SplashController.swift
//  ChatSwift
//
//  Created by Ty on 5/8/19.
//  Copyright © 2019 Ty. All rights reserved.
//

import Foundation
import UIKit

class SplashController: UIViewControllerWithExtension {
    override func viewDidLoad() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.navigateToLogin();
        }
    }
    
    func navigateToLogin()  {
        let next = DashboardController.instantiateFromAppStoryboard(storyboard: .Authencated);
        present(next, animated: true)
    }
}
