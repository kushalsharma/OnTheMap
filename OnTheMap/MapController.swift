//
//  MapController.swift
//  OnTheMap
//
//  Created by Kushal Sharma on 31/01/17.
//  Copyright © 2017 Kushal. All rights reserved.
//

import UIKit
import MapKit

class MapController: UIViewController, StudentInfoListener, MKMapViewDelegate, SessionInfoListener {
    @IBOutlet weak var mapView: MKMapView!
    var alertView: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertView = getLoadingAlert()

        mapView.showsUserLocation = true
        mapView.delegate = self
        mapView.setCenter(self.mapView.region.center, animated: true)
        
        StudentInfoStore.sharedInstace.getStudentInfo(studentInfoListener: self)
    }
    
    func onSuccess(studentInfoList: [StudentInfo]) {
        for studentInfo in studentInfoList {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: studentInfo.latitude, longitude: studentInfo.longitude)
            annotation.title = studentInfo.firstName + " " + studentInfo.lastName
            annotation.subtitle = studentInfo.mediaURL
            self.mapView.addAnnotation(annotation)
        }
    }
    
    func onNetworkFailure(error: Any) {
        showAlert(title: "Network error",message: "Something went wrong", actionTitle: "Okay")
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            pinView!.annotation = annotation
        }
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                app.open(NSURL(string:toOpen) as! URL, options: [:], completionHandler: nil)
            }
        }
    }
    
    @IBAction func logoutButtonClicked(_ sender: UIBarButtonItem) {
        present(alertView, animated: true, completion: nil)
        SessionStore.sharedInstace.makeLogoutRequest(sessionInfoListener: self)
    }
    
    func onSuccess(data: SessionInfo) {
        alertView.dismiss(animated: true, completion: nil)
        dismiss(animated: true, completion: nil)
    }
    
    func onIncorrectCredentials() {
        // Nothing to do here
    }
    
    // Presents user a Alert View
    func showAlert(title: String, message: String, actionTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default) { action in
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
    
    @IBAction func postLocationClicked(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "createNewPost", sender: self)
    }
}
