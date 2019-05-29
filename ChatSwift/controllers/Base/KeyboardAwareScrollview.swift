//
//  KeyboardAwareScrollview.swift
//  ChatSwift
//
//  Created by Ty on 5/11/19.
//  Copyright © 2019 Ty. All rights reserved.
//

import Foundation
import UIKit

class KeyboardAwareScrollview: UIViewControllerWithExtension {
    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad();
        onViewDidLoad();
    }
    
    func onViewDidLoad() ->  Void {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture);
        scrollView.alwaysBounceHorizontal = false;
        scrollView.keyboardDismissMode = .none;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        addObservers();
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        removeObservers();
    }
    @objc  func didTapView(gesture: UITapGestureRecognizer) {
        view.endEditing(true);
    }
    func addObservers() {
        NotificationCenter.default
            .addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default
            .addObserver(self, selector: #selector(keyboardDidHide(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    func removeObservers(){
        NotificationCenter.default.removeObserver(self);
    }
    @objc  func keyboardDidShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
            let frame = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else{
                return
        }
        
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height + 40, right: 0)
        self.scrollView.contentInset = contentInset;
        self.scrollView.layoutIfNeeded();
    }
    @objc  func keyboardDidHide(notification: Notification) {
        scrollView.contentInset = UIEdgeInsets.zero;
    }
}
