//
//  LoginTextField.swift
//  OnTheMap
//
//  Created by Ty Hopp on 12/11/21.
//

import UIKit

// TODO: Implement

class LoginTextField: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        defaultTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.label
        ]
        
        autocorrectionType = .no
    }
}
