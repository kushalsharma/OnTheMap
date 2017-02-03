//
//  LocateOnMapController.swift
//  OnTheMap
//
//  Created by Kushal Sharma on 03/02/17.
//  Copyright © 2017 Kushal. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class LocateOnMapController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var submitClicked: UIButton!
    var latitude: Double? = nil
    var longitude: Double? = nil
    
    var enteredLocation: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        createGeoLocationFromAddress(enteredLocation!, mapView: mapView)
    }
    
    func createGeoLocationFromAddress(_ address: String, mapView: MKMapView) {
        let completion:CLGeocodeCompletionHandler = {(placemarks: [CLPlacemark]?, error: Error?) in
            if let placemarks = placemarks {
                for placemark in placemarks {
                    mapView.removeAnnotations(mapView.annotations)
                    // Instantiate annotation
                    let annotation = MKPointAnnotation()
                    // Annotation coordinate
                    annotation.coordinate = (placemark.location?.coordinate)!
                    self.longitude = annotation.coordinate.longitude
                    self.latitude = annotation.coordinate.latitude
                    annotation.subtitle = placemark.subLocality
                    mapView.addAnnotation(annotation)
                    mapView.showsPointsOfInterest = true
                    self.centerMapOnLocation(placemark.location!, mapView: mapView)
                }
            } else {
                // Handle error
            }
        }
        
        CLGeocoder().geocodeAddressString(address, completionHandler: completion)
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        // once annotationView is added to the map, get the last one added unless it is the user's location:
        if let annotationView = views.last {
            // show callout programmatically:
            mapView.selectAnnotation(annotationView.annotation!, animated: false)
            // zoom to all annotations on the map:
            mapView.showAnnotations(mapView.annotations, animated: true)
        }
    }
    
    func centerMapOnLocation(_ location: CLLocation, mapView: MKMapView) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    @IBAction func cancelButtonClicked(_ sender: UIBarButtonItem) {
            dismiss(animated: true, completion: nil)
    }
}
