//
//  UIViewController+ErrorAlert.swift
//  OnTheMap
//
//  Created by Ty Hopp on 4/12/21.
//

import UIKit

extension UIViewController {
    
    func showErrorAlert(_ error: Error, title: String) -> Void {
        let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        show(alert, sender: nil)
    }
}
