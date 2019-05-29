//
//  LoginController.swift
//  ChatSwift
//
//  Created by Ty on 5/8/19.
//  Copyright © 2019 Ty. All rights reserved.
//

import Foundation
import UIKit

import FBSDKLoginKit
import GoogleSignIn

class LoginController: KeyboardAwareScrollview, GIDSignInUIDelegate {

    @IBOutlet weak var societyLoginBtnStackView: UIStackView!
    @IBOutlet weak var usernameTxt: InputField!
    @IBOutlet weak var passwordTxt: InputField!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        GIDSignIn.sharedInstance()?.uiDelegate = self;
        
       intiView()
    }
    
    func intiView()  {
        let fbloginButton = FBLoginButton(frame: CGRect(x: 100, y: 200, width: 150, height: 50))
        
        let gLoginBtn = GIDSignInButton(frame:  CGRect(x: 100, y: 200, width: 150, height: 50))
        
        societyLoginBtnStackView.addArrangedSubview(fbloginButton)
        societyLoginBtnStackView.addArrangedSubview(gLoginBtn)
        
        usernameTxt.initWithChildren(chidren: [.leftIcon, .textInput, .error])
        usernameTxt.leftIcon.image = UIImage.fontAwesomeIcon(name: .user, style: .regular, textColor: .orange, size: CGSize(width: 30, height: 30))
        
        passwordTxt.initWithChildren(chidren: [.leftIcon, .textInput, .error])
        passwordTxt.leftIcon.image = UIImage.fontAwesomeIcon(name: .key, style: .solid, textColor: .orange, size: CGSize(width: 30, height: 30));
        passwordTxt.textInput.isSecureTextEntry = true
    }
    
}

extension LoginController {
    @IBAction func doLogin(_ sender: Any) {
        ActivityIndicator.shared.showIndicator()
        User.shared.getProfile(){ (profile) in
            ActivityIndicator.shared.hideIndicator();
            self.didLoginSuccess();
        };
    }
    
    func didLoginSuccess(){
        let next = DashboardController.instantiateFromAppStoryboard(storyboard: .Authencated);
        present(next, animated: true);
    }
}

