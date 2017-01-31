//
//  LoginControllerValidator.swift
//  OnTheMap
//
//  Created by Kushal Sharma on 31/01/17.
//  Copyright © 2017 Kushal. All rights reserved.
//

import Foundation
import UIKit

extension LoginController {
    
    // Checks if is a valid email
    func isValidEmail(stringEmail: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: stringEmail)
    }
    
    // Presents user a Alert View 
    func showAlert(title: String, message: String, actionTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default) { action in
            // perhaps use action.title here
        })
        present(alert, animated: true, completion: nil)
    }
    
    func doLoginIfCredentialsValid(sessionInfoListener: SessionInfoListener) {
        // Check if user entered valid email addredd and password
        if (isValidEmail(stringEmail: emailTextView.text!) && (passwordTextView.text?.characters.count)! > 5) {
            // Make network call with username and password
            SessionStore.sharedInstace.makeSessionRequest(username: emailTextView.text!,
                                                          password: passwordTextView.text!,
                                                          sessionInfoListener: sessionInfoListener)
        } else {
            // Alert user for incorrect credentials
            sessionInfoListener.onIncorrectCredentials()
        }
    }
    
    // Performs a segue for specified ID and sender as self
    func performSegueForId(id: String) {
        performSegue(withIdentifier: id, sender: self)
    }
}
