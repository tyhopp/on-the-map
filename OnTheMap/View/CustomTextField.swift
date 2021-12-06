//
//  LoginTextField.swift
//  OnTheMap
//
//  Created by Ty Hopp on 12/11/21.
//

import UIKit

class CustomTextField: UITextField, UITextFieldDelegate {
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        defaultTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.label
        ]
        delegate = self
    }
    
    // MARK: Delegate
    
    // Hide keyboard on return button tap
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
        return true
    }
}
