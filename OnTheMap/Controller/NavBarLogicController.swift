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
                self.showErrorAlert(error, title: "Logout Failed")
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
        rotate(view: imageView, start: loading)
    }
    
    func showErrorAlert(_ error: Error, title: String) -> Void {
        let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        context.show(alert, sender: nil)
    }
    
    func rotate(view: UIView?, start: Bool) -> Void {
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
