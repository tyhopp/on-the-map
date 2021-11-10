//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Ty Hopp on 10/11/21.
//

import UIKit

class LoginViewController: UIViewController {

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

