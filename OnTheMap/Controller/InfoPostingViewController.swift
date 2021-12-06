//
//  InfoPostingFieldViewController.swift
//  OnTheMap
//
//  Created by Ty Hopp on 6/12/21.
//

import UIKit

class InfoPostingViewController: UIViewController {
    
    var inputLogicController: InputLogicController?
    
    // MARK: Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.inputLogicController = InputLogicController(self)
    }
    
    // MARK: - Outlet
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var mediaURLTextField: UITextField!
    @IBOutlet weak var findLocationButton: UIButton!
    
    // MARK: - Action
    
    @IBAction func locationTextFieldChanged(_ sender: Any) {
        inputLogicController?.checkMaySubmit(button: findLocationButton, textFields: [locationTextField, mediaURLTextField])
    }
    
    @IBAction func mediaURLTextFieldChanged(_ sender: Any) {
        inputLogicController?.checkMaySubmit(button: findLocationButton, textFields: [locationTextField, mediaURLTextField])
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
