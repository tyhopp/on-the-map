//
//  UIViewController+RotateAnimation.swift
//  OnTheMap
//
//  Created by Ty Hopp on 3/12/21.
//

import UIKit

extension UIViewController {
    
    func rotate(view: UIView?, start: Bool) {
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
