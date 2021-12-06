//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Ty Hopp on 3/12/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    var navBarLogicController: NavBarLogicController?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarLogicController = NavBarLogicController(self)
        fillMapView()
    }
    
    // MARK: Outlets
    
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: Actions
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        self.navBarLogicController?.handleLogoutButtonPress(logoutButton)
    }
    
    @IBAction func refreshButtonPressed(_ sender: Any) {
        self.navBarLogicController?.handleRefreshButtonPress(refreshButton, reload: fillMapView)
    }
    
    // MARK: Delegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "marker"
        
        var markerView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKMarkerAnnotationView

        if markerView == nil {
            markerView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            markerView?.canShowCallout = true
            markerView?.markerTintColor = .systemBlue
            markerView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            markerView?.annotation = annotation
        }
        
        return markerView
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let url = view.annotation?.subtitle! {
                UIApplication.shared.open(URL(string: url)!, completionHandler: { success in
                    if !success {
                        self.showErrorAlert(title: "Failed to open URL", description: "Ensure that the URL is valid.")
                    }
                })
            }
        }
    }
    
    // MARK: Helper
    
    func fillMapView(completion: @escaping () -> Void = {}) -> Void {
        // In a real project we would share data with the table view and conditionally make network requests, but we'll consider it out of scope for this project
        
        UdacityClient.getStudentLocations(completion: { response, error in
            var annotations = [MKPointAnnotation]()
            
            if let locations = response?.results {
                for location in locations {
                    let lat = CLLocationDegrees(location.latitude)
                    let long = CLLocationDegrees(location.longitude)
                    
                    let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                    
                    let first = location.firstName
                    let last = location.lastName
                    let mediaURL = location.mediaURL
                    
                    let annotation = MKPointAnnotation()
                    
                    annotation.coordinate = coordinate
                    annotation.title = "\(first) \(last)"
                    annotation.subtitle = mediaURL
                    
                    annotations.append(annotation)
                }
            }
        
            self.mapView.addAnnotations(annotations)
            
            completion()
        })
    }
}
