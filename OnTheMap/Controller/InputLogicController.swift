//
//  InputLogicController.swift
//  OnTheMap
//
//  Created by Ty Hopp on 4/12/21.
//

import UIKit

/**
 Handles shared input logic.
 */
class InputLogicController {
    
    var context: UIViewController
    
    init(_ context: UIViewController) {
        self.context = context
    }
    
    func checkMaySubmit(button: UIButton, textFields: [UITextField]) -> Void {
        // Would use proper validation in a real application, checking for text is enough here
        button.isEnabled = textFields.allSatisfy({ $0.hasText })
    }
    
    /**
     Cannot be shared with `NavBarLogicController.toggleLoadingIndicator` because `UIButton` and `UIBarButtonItem` have different interfaces.
     */
    func toggleLoadingIndicator(_ button: UIButton, loading: Bool, title: String = "", image: UIImage = UIImage()) -> Void {
        button.isEnabled = !loading
        button.setTitle(loading ? "" : title, for: .normal)
        button.setImage(loading ? UIImage(named: "loading")?.withTintColor(.systemCyan) : image, for: .normal)
        self.context.rotate(view: button.imageView, start: loading)
    }
}
