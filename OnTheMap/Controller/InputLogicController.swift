//
//  InputLogicController.swift
//  OnTheMap
//
//  Created by Ty Hopp on 4/12/21.
//

import UIKit

/**
 Handles shared input logic.
 */
class InputLogicController {
    
    var context: UIViewController
    
    init(_ context: UIViewController) {
        self.context = context
    }
    
    // MARK: Validation
    
    func checkMaySubmit(button: UIButton, textFields: [UITextField]) -> Void {
        // Would use proper validation in a real application, checking for text is enough here
        button.isEnabled = textFields.allSatisfy({ $0.hasText })
    }
    
    // MARK: Loading
    
    /**
     Cannot be shared with `NavBarLogicController.toggleLoadingIndicator` because `UIButton` and `UIBarButtonItem` have different interfaces. They're different enough there's not a big gain if we generalize.
     */
    func toggleLoadingIndicator(_ button: UIButton, loading: Bool, title: String = "", image: UIImage = UIImage()) -> Void {
        button.isEnabled = !loading
        button.setTitle(loading ? "" : title, for: .normal)
        button.setImage(loading ? UIImage(named: "loading")?.withTintColor(.systemCyan) : image, for: .normal)
        self.context.rotate(view: button.imageView, start: loading)
    }
    
    /**
     Not used any longer but will keep because it's a nice solution for use in modally preseented view controllers.
     */
    func toggleErrorIndicator(_ button: UIButton, title: String = "Error") -> Void {
        let originalTitle = button.title(for: .normal)
        
        button.tintColor = .systemRed
        button.setTitle(title, for: .normal)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            button.tintColor = .systemBlue
            button.setTitle(originalTitle, for: .normal)
        }
    }
    
    // MARK: Observer
    
    func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: Keyboard
    
    @objc func keyboardWillShow(_ notification: Notification) -> Void {
        context.view.frame.origin.y = -getHalfKeyboardHeight(notification)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) -> Void {
        context.view.frame.origin.y += getHalfKeyboardHeight(notification)
    }
    
    func getHalfKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height / 2
    }
}
