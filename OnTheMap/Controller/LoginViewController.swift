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
        passwordTextField.isSecureTextEntry = true
        loginButton.isEnabled = false
    }
    
    // MARK: Actions
    
    @IBAction func emailTextChanged(_ sender: Any) {
        checkMayLogin()
    }
    
    @IBAction func passwordTextChanged(_ sender: Any) {
        checkMayLogin()
    }
    
    @IBAction func login(_ sender: Any) -> Void {
        UdacityClient.login(username: emailTextField.text!, password: passwordTextField.text!, completion: { success, error in
            if let error = error {
                self.showLoginErrorAlert(error: error)
                return
            }
            
            // TODO - Segue to tab navigator map view
        })
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
}

// MARK: Preview

#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct LoginView: PreviewProvider {
    static var previews: some View {
        LoginViewController().preview(storyboardId: "LoginViewController").previewInterfaceOrientation(.portrait)
    }
}
#endif
