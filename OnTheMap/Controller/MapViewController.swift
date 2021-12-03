//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Ty Hopp on 3/12/21.
//

import UIKit

class MapViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UdacityClient.getStudentLocations(completion: { response, error in
            print(response as Any)
        })
    }
    
    // MARK: Outlets
    
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    
    // MARK: Actions
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        self.toggleLoadingIndicator(loading: true)
        
        UdacityClient.logout(completion: { success, error in
            self.toggleLoadingIndicator(loading: false)
            
            if let error = error {
                self.showErrorAlert(error: error, title: "Logout Failed")
                return
            }
            
            if let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") {
                if let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                    scene.setRootViewController(loginViewController)
                }
            }
        })
    }
    
    // MARK: Helper
    
    private func toggleLoadingIndicator(loading: Bool) {
        logoutButton.isEnabled = !loading
        logoutButton.title = loading ? "" : "Logout"
        let imageView = UIImageView(image: loading ? UIImage(named: "loading")?.withTintColor(.systemBlue) : UIImage())
        logoutButton.customView = imageView
        rotate(view: imageView, start: loading)
    }
}
