//
//  UIViewController+ErrorAlert.swift
//  OnTheMap
//
//  Created by Ty Hopp on 3/12/21.
//

import UIKit

extension UIViewController {
    
    func showErrorAlert(error: Error, title: String) {
        let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        show(alert, sender: nil)
    }
}
