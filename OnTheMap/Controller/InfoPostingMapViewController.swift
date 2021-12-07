//
//  InfoPostingMapViewController.swift
//  OnTheMap
//
//  Created by Ty Hopp on 6/12/21.
//

import UIKit
import MapKit

class InfoPostingMapViewController: UIViewController, MKMapViewDelegate {
    
    var mark: CLPlacemark?
    var mediaURL: String?
    
    var inputLogicController: InputLogicController?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMark()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.inputLogicController = InputLogicController(self)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: Outlet
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var finishButton: UIButton!
    
    // MARK: Action
    
    @IBAction func finishButtonPressed(_ sender: Any) {
        inputLogicController?.toggleLoadingIndicator(finishButton, loading: true, title: "Finish")
        
        // Would use async/await in a real scenario, closure callbacks are fine for now
        UdacityClient.getUser(completion: { response, error in
            if error != nil {
                self.inputLogicController?.toggleLoadingIndicator(self.finishButton, loading: false, title: "Finish")
                self.showErrorAlert(title: "Failed to get user ID", description: "Please try again or contact the developer.")
                return
            }
            
            let mark = self.mark
            let coordinate = mark?.location?.coordinate
            
            if let first = response?.firstName, let last = response?.lastName, let address = mark?.name, let mediaURL = self.mediaURL, let lat = coordinate?.latitude, let long = coordinate?.longitude {
                let date = Date().iso8601
                let payload = StudentInformation(createdAt: date, firstName: first, lastName: last, latitude: Float(lat), longitude: Float(long), mapString: address, mediaURL: mediaURL, objectId: "", uniqueKey: UdacityClient.Auth.accountKey, updatedAt: date)
                UdacityClient.postStudentLocation(payload, completion: { response, error in
                    self.inputLogicController?.toggleLoadingIndicator(self.finishButton, loading: false, title: "Finish")
                    
                    if error != nil {
                        self.showErrorAlert(title: "Failed to submit data", description: "Please try again or contact the developer.")
                        return
                    }
                    
                    self.returnToStackRootAndRefresh()
                })
            }
        })
    }
    
    // MARK: Delegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "marker"
        
        let markerView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKMarkerAnnotationView
        markerView?.markerTintColor = .systemBlue
        markerView?.annotation = annotation
        
        return markerView
    }
    
    // MARK: Helper
    
    func setMark() -> Void {
        if let mark = mark {
            let annotation = MKPointAnnotation()
            
            if let coordinate = mark.location?.coordinate {
                annotation.coordinate = coordinate
                annotation.title = mark.name
                mapView.addAnnotations([annotation])
                mapView.centerCoordinate = coordinate
            }
        }
    }
    
    func returnToStackRootAndRefresh() -> Void {
        if let rootOfStackController = self.navigationController?.viewControllers.first {
            if rootOfStackController is MapViewController {
                let mapViewController = rootOfStackController as! MapViewController
                mapViewController.fillMapView(completion: {
                    self.navigationController?.popToViewController(rootOfStackController, animated: true)
                })
            } else if rootOfStackController is TableViewController {
                let tableViewController = rootOfStackController as! TableViewController
                tableViewController.fillTableView(completion: {
                    self.navigationController?.popToViewController(rootOfStackController, animated: true)
                })
            } else {
                self.navigationController?.popToViewController(rootOfStackController, animated: true)
            }
        }
    }
}
