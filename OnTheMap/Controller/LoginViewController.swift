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
    @IBOutlet weak var passworldTextField: LoginTextField!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Test login method
        UdacityClient.login(username: "account@domain.com", password: "********", completion: { success, error in
            print("Success: \(success)")
            
            print("Auth session id: \(UdacityClient.Auth.sessionId)")
            print("Auth session expiration: \(UdacityClient.Auth.sessionExpiration)")
            
            if let error = error {
                print("Error: \(error)")
            }
        })
    }
}

// MARK: Preview

#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct LoginView: PreviewProvider {
    static var previews: some View {
        LoginViewController().preview(storyboardId: "LoginViewController")
    }
}
#endif
