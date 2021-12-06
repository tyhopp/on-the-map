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
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        inputLogicController?.removeObservers()
        self.tabBarController?.tabBar.isHidden = false
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
                
                if let mark = mark?.first {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let infoPostingMapViewController = storyboard.instantiateViewController(withIdentifier: "InfoPostingMapViewController") as! InfoPostingMapViewController
                    infoPostingMapViewController.mark = mark
                    self.navigationController?.pushViewController(infoPostingMapViewController, animated: true)
                }
            })
        }
    }
}
