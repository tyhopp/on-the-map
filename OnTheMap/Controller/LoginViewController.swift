//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Ty Hopp on 10/11/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    var inputLogicController: InputLogicController?
    
    // MARK: Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.inputLogicController = InputLogicController(self)
        setupObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObservers()
    }
    
    // MARK: Outlets
    
    @IBOutlet weak var emailTextField: LoginTextField!
    @IBOutlet weak var passwordTextField: LoginTextField!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: Actions
    
    @IBAction func emailTextChanged(_ sender: Any) {
        inputLogicController?.checkMaySubmit(button: loginButton, textFields: [emailTextField, passwordTextField])
    }
    
    @IBAction func passwordTextChanged(_ sender: Any) {
        inputLogicController?.checkMaySubmit(button: loginButton, textFields: [emailTextField, passwordTextField])
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) -> Void {
        emailTextField.endEditing(true)
        passwordTextField.endEditing(true)
        inputLogicController?.toggleLoadingIndicator(loginButton, loading: true, title: "Log In")
        
        UdacityClient.login(username: emailTextField.text!, password: passwordTextField.text!, completion: { success, error in
            self.inputLogicController?.toggleLoadingIndicator(self.loginButton, loading: false, title: "Log In")
            
            if let error = error {
                self.showErrorAlert(title: "Login Failed", description: error.localizedDescription)
                return
            }
            
            if let tabViewController = self.storyboard?.instantiateViewController(withIdentifier: "TabViewController") {
                if let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                    scene.setRootViewController(tabViewController)
                }
            }
        })
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
    
    // MARK: Keyboard
    
    @objc func keyboardWillShow(_ notification: Notification) -> Void {
        view.frame.origin.y = -getHalfKeyboardHeight(notification)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) -> Void {
        view.frame.origin.y += getHalfKeyboardHeight(notification)
    }
    
    func getHalfKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height / 2
    }
}
