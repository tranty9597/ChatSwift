//
//  InputField.swift
//  ChatSwift
//
//  Created by Ty on 5/9/19.
//  Copyright © 2019 Ty. All rights reserved.
//

import UIKit
import Foundation



enum InputFieldChidren {
    case leftIcon, textInput, rightIcon, label, error
}

class InputField: UIView {
    
    static let HEIGHT_WITHOUT_ERROR: CGFloat = 50
    static let HEIGHT_OF_ERROR_LABEL: CGFloat = 20
    static let HEIGHT_WITH_ERROR: CGFloat = InputField.HEIGHT_WITHOUT_ERROR + InputField.HEIGHT_OF_ERROR_LABEL
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var mainVeritcalStack: UIStackView!
    
    var inputStackContainer: UIView = UIView();
    
    var inputHorizontalStack: UIStackView = UIStackView();
    
    var leftIconContainer: UIView = UIView();
    var leftIcon: UIImageView = UIImageView();
    
    var label: UILabel = UILabel();
    
    var textInput: UITextField = UITextField();
    
    var rightIconContainer: UIView = UIView();
    var rightIcon: UIImageView = UIImageView();
    
    var errorLabel: UILabel = UILabel();
    
    var validateFunction: CGFunctionCallbacks = CGFunctionCallbacks()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    func initWithChildren(chidren: [InputFieldChidren]) -> Void {
        chidren.forEach { (child) in
            switch child {
            case .leftIcon:
                inputHorizontalStack.addArrangedSubview(leftIconContainer);
                break
            case .label:
                inputHorizontalStack.addArrangedSubview(label);
                break
            case .textInput:
                inputHorizontalStack.addArrangedSubview(textInput);
                break
            case .rightIcon:
                inputHorizontalStack.addArrangedSubview(rightIconContainer);
                break
            case .error:
                mainVeritcalStack.addArrangedSubview(errorLabel)
                break
            }
            
        }
    }
    
}

extension InputField {
    func commonInit() {
        Bundle.main.loadNibNamed("InputField", owner: self, options: nil);
        
        self.translatesAutoresizingMaskIntoConstraints = false;
        contentView.translatesAutoresizingMaskIntoConstraints = false;
        self.heightConstaint?.constant = InputField.HEIGHT_WITHOUT_ERROR
        self.addSubview(contentView);
        contentView.fixInView(self);
        
        mainVeritcalStack.fixInView(contentView)
    
        inputStackContainer.addSubview(inputHorizontalStack);
        
        inputStackContainer.layer.masksToBounds = true
        inputStackContainer.layer.cornerRadius = 10
        inputStackContainer.setHeight(height: InputField.HEIGHT_WITHOUT_ERROR)
        
        inputHorizontalStack.fixInView(inputStackContainer)
        mainVeritcalStack.addArrangedSubview(inputStackContainer);
        
//        textInput.textColor = .white
        textInput.addTarget(self, action: #selector(onChangeText), for: UIControl.Event.editingChanged)
        
        initLeftIcon();
        initRightIcon();
        
        errorLabel.setHeight(height: 0)
        errorLabel.setWidth(width: mainVeritcalStack.frame.size.width)
        errorLabel.textColor = .red
        
        
    }
    func initLeftIcon(){
        leftIconContainer.addSubview(leftIcon);
        leftIconContainer.setWidth(width: 45)
        leftIconContainer.setCenterSubview(subView: leftIcon)
        leftIcon.translatesAutoresizingMaskIntoConstraints = false;
    }
    
    func initRightIcon() {
        rightIconContainer.addSubview(rightIcon);
        rightIconContainer.setWidth(width: 45)
        rightIconContainer.setCenterSubview(subView: rightIcon)
        rightIcon.translatesAutoresizingMaskIntoConstraints = false;
    }
}

private extension InputField {
    
    @objc func onChangeText(){
        if textInput.text?.count ?? 0 % 2 > 0 {
            self.heightConstaint?.constant = InputField.HEIGHT_WITHOUT_ERROR
            errorLabel.heightConstaint?.constant = 0;
            errorLabel.text = ""
        }else{
             self.heightConstaint?.constant = InputField.HEIGHT_WITH_ERROR
            errorLabel.heightConstaint?.constant = InputField.HEIGHT_OF_ERROR_LABEL;
            errorLabel.text = "test"
        }
    }
    
}

