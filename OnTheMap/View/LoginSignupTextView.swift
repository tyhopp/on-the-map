//
//  LoginSignupTextView.swift
//  OnTheMap
//
//  Created by Ty Hopp on 12/11/21.
//

import UIKit

class LoginSignupTextView: UITextView, UITextViewDelegate {
    
    private struct Content {
        static let text = "Don't have an account? Sign Up"
        static let link = "https://auth.udacity.com/sign-up"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Compose text content
        let signupText = NSMutableAttributedString(string: Content.text)
        signupText.addAttribute(.link, value: Content.link, range: NSRange(location: 23, length: 7))
        attributedText = signupText
        
        // Style
        font = .systemFont(ofSize: 16.0)
        textColor = .label
        textAlignment = .center
    }

    // Handle links
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }
}
