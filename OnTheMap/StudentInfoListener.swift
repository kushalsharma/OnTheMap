//
//  StudentInfoListener.swift
//  OnTheMap
//
//  Created by Kushal Sharma on 31/01/17.
//  Copyright © 2017 Kushal. All rights reserved.
//

import Foundation

protocol StudentInfoListener {
    func onSuccess(data: StudentInfo)
    
    func onNetworkFailure(error: Any)
}
