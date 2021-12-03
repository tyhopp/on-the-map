//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Ty Hopp on 3/12/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillMapView()
    }
    
    // MARK: Outlets
    
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: Actions
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        self.toggleLoadingIndicator(loading: true)
        
        UdacityClient.logout(completion: { success, error in
            self.toggleLoadingIndicator(loading: false)
            
            if let error = error {
                self.showErrorAlert(error: error, title: "Logout Failed")
                return
            }
            
            if let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") {
                if let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                    scene.setRootViewController(loginViewController)
                }
            }
        })
    }
    
    // MARK: Map view delegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView

        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .systemRed
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let _ = view.annotation?.subtitle {
                // TODO - Open URL
            }
        }
    }
    
    // MARK: Helper
    
    private func fillMapView() {
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
        })
    }
    
    private func toggleLoadingIndicator(loading: Bool) {
        logoutButton.isEnabled = !loading
        logoutButton.title = loading ? "" : "Logout"
        let imageView = UIImageView(image: loading ? UIImage(named: "loading")?.withTintColor(.systemBlue) : UIImage())
        logoutButton.customView = imageView
        rotate(view: imageView, start: loading)
    }
}
