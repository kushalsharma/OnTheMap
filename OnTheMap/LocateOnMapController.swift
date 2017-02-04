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

class LocateOnMapController: UIViewController, MKMapViewDelegate, SubmitUserInfoListener, UITextViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var submitClicked: UIButton!
    var latitude: Double? = nil
    var longitude: Double? = nil
    
    var alertView: UIViewController!
    
    var enteredLocation: String?
    var firstName: String?
    var lastName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        createGeoLocationFromAddress(enteredLocation!, mapView: mapView)
        alertView = getLoadingAlert()
        textView.delegate = self
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
                self.showAlert(title: "Error",message: "Something went wrong", actionTitle: "Okay")
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
    
    @IBAction func submitButtonClicked(_ sender: Any) {
        if(NetworkHelper.isInternetAvailable()) {
            present(alertView, animated: true, completion: nil)
            SessionStore.sharedInstace.submitUserInfo(submitUserInfoListener: self, key: (SessionStore.sharedInstace.sessionInfo?.account.key)!, firstName: firstName!, lastName: lastName!, mapString: enteredLocation!, mediaURL: textView.text, latitude: latitude!, longitude: longitude!)
            
        } else {
            showAlert(title: "Network Error",message: "Network not available", actionTitle: "Okay")
        }
    }
    
    func onSuccess() {
        alertView.dismiss(animated: true, completion: nil)
        dismiss(animated: true, completion: nil)
    }
    
    func onError() {
        alertView.dismiss(animated: true, completion: nil)
        showAlert(title: "Error",message: "Something went wrong", actionTitle: "Okay")
    }
    
    func showAlert(title: String, message: String, actionTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default) { action in
            // perhaps use action.title here
        })
        present(alert, animated: true, completion: nil)
    }
    
    func getLoadingAlert() -> UIViewController {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        alert.view.tintColor = UIColor.black
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50,height: 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        return alert
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
