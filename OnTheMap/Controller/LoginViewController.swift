//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Ty Hopp on 10/11/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var emailTextField: LoginTextField!
    @IBOutlet weak var passwordTextField: LoginTextField!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObservers()
    }
    
    // MARK: Observers
    
    func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: Actions
    
    @IBAction func emailTextChanged(_ sender: Any) {
        checkMayLogin()
    }
    
    @IBAction func passwordTextChanged(_ sender: Any) {
        checkMayLogin()
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) -> Void {
        emailTextField.endEditing(true)
        passwordTextField.endEditing(true)
        toggleLoadingIndicator(loading: true)
        
        UdacityClient.login(username: emailTextField.text!, password: passwordTextField.text!, completion: { success, error in
            self.toggleLoadingIndicator(loading: false)
            
            if let error = error {
                self.showLoginErrorAlert(error: error)
                return
            }
            
            // TODO - Segue to tab navigator map view
        })
    }
    
    // MARK: Keyboard
    
    @objc func keyboardWillShow(_ notification: Notification) -> Void {
        view.frame.origin.y = -getHalfKeyboardHeight(notification)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) -> Void {
        view.frame.origin.y += getHalfKeyboardHeight(notification)
    }
    
    private func getHalfKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height / 2
    }
    
    // MARK: Helper
    
    private func checkMayLogin() -> Void {
        // Would use proper validation in a real application, this is fine here
        loginButton.isEnabled = emailTextField.hasText && passwordTextField.hasText
    }
    
    private func showLoginErrorAlert(error: Error) {
        let alert = UIAlertController(title: "Login Failed", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        show(alert, sender: nil)
    }
    
    private func toggleLoadingIndicator(loading: Bool) {
        loginButton.isEnabled = !loading
        loginButton.setTitle(loading ? "" : "Log In", for: .normal)
        loginButton.setImage(loading ? UIImage(named: "loading") : UIImage(), for: .normal)
        rotate(view: loginButton.imageView, start: loading)
    }
    
    private func rotate(view: UIView?, start: Bool) {
        guard start else {
            view?.layer.removeAnimation(forKey: "rotationAnimation")
            return
        }
        
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        view?.layer.add(rotation, forKey: "rotationAnimation")
    }
}

// MARK: Preview

//#if canImport(SwiftUI) && DEBUG
//import SwiftUI
//
//@available(iOS 13.0, *)
//struct LoginView: PreviewProvider {
//    static var previews: some View {
//        LoginViewController().preview(storyboardId: "LoginViewController").previewInterfaceOrientation(.portrait)
//    }
//}
//#endif
