//
//  LoginTextField.swift
//  OnTheMap
//
//  Created by Ty Hopp on 12/11/21.
//

import UIKit

class LoginTextField: UITextField, UITextFieldDelegate {
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        defaultTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.label
        ]
        autocorrectionType = .no
        delegate = self
    }
    
    // MARK: Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
        return true
    }
}
