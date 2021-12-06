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
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMark()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: Outlet
    
    @IBOutlet weak var mapView: MKMapView!
    
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
    
}
