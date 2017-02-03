//
//  ViewController.swift
//  OnTheMap
//
//  Created by Kushal Sharma on 31/01/17.
//  Copyright © 2017 Kushal. All rights reserved.
//

import UIKit

class LoginController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailTextView: UITextField!
    @IBOutlet weak var passwordTextView: UITextField!
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextView.delegate = self
        passwordTextView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        subscribeToKeyboardNotifications()
        progressIndicator.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    @IBAction func loginClicked(_ sender: UIButton) {
        progressIndicator.isHidden = false
        doLoginIfCredentialsValid(sessionInfoListener: self)
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        UIApplication.shared.open(NSURL(string:"https://auth.udacity.com/sign-up") as! URL, options: [:], completionHandler: nil)
    }
    
}

