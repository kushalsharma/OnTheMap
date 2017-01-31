//
//  StudentInfoProtocol.swift
//  OnTheMap
//
//  Created by Kushal Sharma on 31/01/17.
//  Copyright © 2017 Kushal. All rights reserved.
//

import Foundation

protocol SessionInfoListener {
    func onSuccess(data: SessionInfo)
    
    func onNetworkFailure(error: Any)
    
    func onIncorrectCredentials()
}
