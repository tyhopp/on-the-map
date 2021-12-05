//
//  UIViewController+ErrorAlert.swift
//  OnTheMap
//
//  Created by Ty Hopp on 4/12/21.
//

import UIKit

extension UIViewController {
    
    func showErrorAlert(title: String, description: String) -> Void {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        show(alert, sender: nil)
    }
}
