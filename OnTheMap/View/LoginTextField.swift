//
//  LoginTextField.swift
//  OnTheMap
//
//  Created by Ty Hopp on 12/11/21.
//

import UIKit

// TODO: Implement

class LoginTextField: UITextField, UITextFieldDelegate {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        defaultTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.label
        ]
        autocorrectionType = .no
        delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
        return true
    }
}
