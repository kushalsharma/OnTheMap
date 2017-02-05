//
//  CreatePostController.swift
//  OnTheMap
//
//  Created by Kushal Sharma on 01/02/17.
//  Copyright © 2017 Kushal. All rights reserved.
//

import Foundation
import UIKit

class CreatePostController: UIViewController, UITextFieldDelegate, UserInfoListener {
    @IBOutlet weak var userLocationTextView: UITextField!
    var latitude: Double? = nil
    var longitude: Double? = nil

    var firstName: String?
    var lastName: String?
    
    var alertView: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userLocationTextView.delegate = self
        tabBarController?.tabBar.isHidden = true
        alertView = getLoadingAlert()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func findOnMapClicked(_ sender: UIButton) {
        if (userLocationTextView.text != "" || userLocationTextView.text != nil) {
            if(NetworkHelper.isInternetAvailable()) {
                present(alertView, animated: true, completion: nil)
                SessionStore.sharedInstace.getUserData(userId: (SessionStore.sharedInstace.sessionInfo?.account.key)!, userInfoListener: self)
            } else {
                showAlert(title: "Network Error",message: "Network not available", actionTitle: "Okay")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "locateOnMap") {
            guard let destVC = segue.destination as? LocateOnMapController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            destVC.enteredLocation = userLocationTextView.text
            destVC.firstName = self.firstName
            destVC.lastName = self.lastName
        }
    }
    
    @IBAction func cancelButtonClicked(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func onSuccess(userData: UserData) {
        self.firstName = userData.user.firstName
        self.lastName = userData.user.lastName
        alertView.dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "locateOnMap", sender: self)
    }
    
    func onError() {
        // Show alert
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
}

