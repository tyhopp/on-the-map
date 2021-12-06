//
//  InfoPostingFieldViewController.swift
//  OnTheMap
//
//  Created by Ty Hopp on 6/12/21.
//

import UIKit
import CoreLocation

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
    
    @IBAction func findLocationButtonPressed(_ sender: Any) {
        locationTextField.endEditing(true)
        mediaURLTextField.endEditing(true)
        
        inputLogicController?.toggleLoadingIndicator(findLocationButton, loading: true, title: "Find Location")
        
        let geocoder = CLGeocoder()
        
        if let addressString = locationTextField.text {
            geocoder.geocodeAddressString(addressString, completionHandler: { mark, error in
                self.inputLogicController?.toggleLoadingIndicator(self.findLocationButton, loading: false, title: "Find Location")
                
                if error != nil {
                    self.inputLogicController?.toggleErrorIndicator(self.findLocationButton, title: "Failed to geocode")
                    return
                }
                
                // TODO - Parse mark and POST
            })
        }
    }
}
