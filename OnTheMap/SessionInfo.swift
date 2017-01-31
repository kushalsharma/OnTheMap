//
//  SessionInfo.swift
//  OnTheMap
//
//  Created by Kushal Sharma on 31/01/17.
//  Copyright © 2017 Kushal. All rights reserved.
//

import Foundation

struct SessionInfo {
    let account: Account
    let session: Session
    
    init?(json: [String: Any]) {
        guard let account = json["account"] as? [String: Any],
            let registered = account["registered"] as? Bool,
            let key = account["key"] as? String,
            let session = json["session"] as? [String: Any],
            let id = session["id"] as? String,
            let expiration = session["expiration"] as? String
            else {
                return nil
        }
        
        self.account = Account(registered: registered, key: key)
        self.session = Session(id: id, expiration: expiration)
    }
}
