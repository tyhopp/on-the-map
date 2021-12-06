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
        inputLogicController?.setupObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        inputLogicController?.removeObservers()
    }
    
    // MARK: - Outlet
    
    @IBOutlet weak var locationTextField: CustomTextField!
    @IBOutlet weak var mediaURLTextField: CustomTextField!
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
