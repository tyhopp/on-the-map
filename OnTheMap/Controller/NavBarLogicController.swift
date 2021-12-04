//
//  NavBarLogicController.swift
//  OnTheMap
//
//  Created by Ty Hopp on 4/12/21.
//

import UIKit

class NavBarLogicController {
    
    var context: UIViewController
    
    init(_ context: UIViewController) {
        self.context = context
    }
    
    func handleLogoutButtonPress(_ logoutButton: UIBarButtonItem) -> Void {
        toggleLoadingIndicator(logoutButton, loading: true)
        
        UdacityClient.logout(completion: { success, error in
            self.toggleLoadingIndicator(logoutButton, loading: false)
            
            if let error = error {
                self.context.showErrorAlert(error, title: "Logout Failed")
                return
            }
            
            if let loginViewController = self.context.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") {
                if let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                    scene.setRootViewController(loginViewController)
                }
            }
        })
    }
    
    func toggleLoadingIndicator(_ logoutButton: UIBarButtonItem, loading: Bool) -> Void {
        logoutButton.isEnabled = !loading
        logoutButton.title = loading ? "" : "Logout"
        let imageView = UIImageView(image: loading ? UIImage(named: "loading")?.withTintColor(.systemBlue) : UIImage())
        logoutButton.customView = imageView
        context.rotate(view: imageView, start: loading)
    }
}
