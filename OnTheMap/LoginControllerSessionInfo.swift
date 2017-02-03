//
//  LoginControllerSessionInfo.swift
//  OnTheMap
//
//  Created by Kushal Sharma on 31/01/17.
//  Copyright © 2017 Kushal. All rights reserved.
//

import Foundation

extension LoginController: SessionInfoListener {
    // Login user if everything is fine -> Perform segue
    func onSuccess(data: SessionInfo) {
        performSegue(withIdentifier: "showHomePage", sender: nil)
        progressIndicator.isHidden = true
    }
    
    // Alert user if network calls fail
    func onNetworkFailure(error: Any) {
        showAlert(title: "Network error",message: "Something went wrong", actionTitle: "Okay")
        progressIndicator.isHidden = true
    }
    
    // Alert user if incorrect credentials
    func onIncorrectCredentials() {
        showAlert(title: "Incorrect credentials",message: "Incorrect e-mail address or password", actionTitle: "Okay")
        progressIndicator.isHidden = true
    }
}
