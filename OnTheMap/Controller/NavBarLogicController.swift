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
        toggleLoadingIndicator(logoutButton, loading: true, title: "Logout")
        
        UdacityClient.logout(completion: { success, error in
            self.toggleLoadingIndicator(logoutButton, loading: false, title: "Logout")
            
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
    
    func handleRefreshButtonPress(_ refreshButton: UIBarButtonItem, reload: (_ completion: @escaping () -> Void) -> Void) {
        toggleLoadingIndicator(refreshButton, loading: true, image: UIImage(named: "icon_refresh")!)
        reload() {
            self.toggleLoadingIndicator(refreshButton, loading: false, image: UIImage(named: "icon_refresh")!)
        }
    }
    
    func toggleLoadingIndicator(_ button: UIBarButtonItem, loading: Bool, title: String = "", image: UIImage = UIImage()) -> Void {
        button.isEnabled = !loading
        button.title = loading ? "" : title
        let loadingImageView = UIImageView(image: UIImage(named: "loading")?.withTintColor(.systemBlue))
        button.customView = loading ? loadingImageView : nil
        if loading {
            context.rotate(view: loadingImageView, start: loading)
        }
    }
}
