//
//  CreatePostController.swift
//  OnTheMap
//
//  Created by Kushal Sharma on 01/02/17.
//  Copyright © 2017 Kushal. All rights reserved.
//

import Foundation
import UIKit

class CreatePostController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var userLocationTextView: UITextField!
    var latitude: Double? = nil
    var longitude: Double? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        userLocationTextView.delegate = self
        tabBarController?.tabBar.isHidden = true
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
        if (userLocationTextView.text != "" || userLocationTextView.text != nil){
            performSegue(withIdentifier: "locateOnMap", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "locateOnMap") {
            guard let destVC = segue.destination as? LocateOnMapController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            destVC.enteredLocation = userLocationTextView.text
        }
    }
    @IBAction func backClicked(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

