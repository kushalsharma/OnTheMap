//
//  UserInfoListener.swift
//  OnTheMap
//
//  Created by Kushal Sharma on 03/02/17.
//  Copyright © 2017 Kushal. All rights reserved.
//

import Foundation

protocol UserInfoListener{
    func onSuccess(userData: UserData)
    
    func onError()
}
