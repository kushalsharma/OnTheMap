//
//  SessionStore.swift
//  OnTheMap
//
//  Created by Kushal Sharma on 31/01/17.
//  Copyright © 2017 Kushal. All rights reserved.
//

import Foundation

class SessionStore {
    static let sharedInstace = SessionStore()
    
    private init() {}
    
    var sessionInfo: SessionInfo? = nil
    
    func makeSessionRequest(username: String, password: String, sessionInfoListener: SessionInfoListener) {
        let request = NSMutableURLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}".data(using: String.Encoding.utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil { // Handle error…
                DispatchQueue.main.async {
                    sessionInfoListener.onNetworkFailure(error: error as Any)
                }
                return
            }
            let response = response as! HTTPURLResponse
            let statusCode: Int = response.statusCode
            if statusCode >= 200 && statusCode <= 299 {
                let range = Range(uncheckedBounds: (5, data!.count))
                let newData = data?.subdata(in: range) /* subset response data! */
                let json = try? JSONSerialization.jsonObject(with: newData!, options: [])
                self.sessionInfo = SessionInfo(json: json as! [String : Any])!
                DispatchQueue.main.async {
                    sessionInfoListener.onSuccess(data: self.sessionInfo!)
                }
            } else {
                DispatchQueue.main.async {
                    sessionInfoListener.onIncorrectCredentials()
                }
            }
        }
        task.resume()
    }
    
    func makeLogoutRequest(sessionInfoListener: SessionInfoListener){
        let request = NSMutableURLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil { // Handle error…
                sessionInfoListener.onNetworkFailure(error: "")
                return
            }
            let range = Range(uncheckedBounds: (5, data!.count))
            let newData = data?.subdata(in: range) /* subset response data! */
            print(NSString(data: newData!, encoding: String.Encoding.utf8.rawValue)!)
            sessionInfoListener.onSuccess(data: SessionInfo(registered: false, key: "", id: "", expiration: ""))
        }
        task.resume()
    }
    
    func getUserData(userId: String, userInfoListener: UserInfoListener) {
        print(userId)
        let request = NSMutableURLRequest(url: URL(string: "https://www.udacity.com/api/users/\(userId)")!)
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil { // Handle error...
                userInfoListener.onError()
                return
            }
            let range = Range(uncheckedBounds: (5, data!.count))
            let newData = data?.subdata(in: range) /* subset response data! */
            let json = try? JSONSerialization.jsonObject(with: newData!, options: [])
            
            let userData: UserData?
            do {
                userData = try UserData.init(jsonValue: json)
                DispatchQueue.main.async {
                    userInfoListener.onSuccess(userData: userData!)
                }
            } catch {
                userData = nil
                DispatchQueue.main.async {
                    userInfoListener.onError()
                }
            }
            
        }
        task.resume()
    }
    
    func submitUserInfo(submitUserInfoListener: SubmitUserInfoListener, key: String, firstName: String, lastName: String, mapString: String, mediaURL: String, latitude: Double, longitude: Double) {
        let body: String = "{\"uniqueKey\": \"\(key)\", \"firstName\": \"\(firstName)\", \"lastName\": \"\(lastName)\",\"mapString\": \"\(mapString)\", \"mediaURL\": \"\(mediaURL)\",\"latitude\": \(latitude), \"longitude\": \(longitude)}"
        print(body)
        
        let request = NSMutableURLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation")!)
        request.httpMethod = "POST"
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body.data(using: String.Encoding.utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil { // Handle error…
                DispatchQueue.main.async {
                    submitUserInfoListener.onError()
                }
                return
            }
            let response = response as! HTTPURLResponse
            let statusCode: Int = response.statusCode
            if statusCode >= 200 && statusCode <= 299 {
                DispatchQueue.main.async {
                    submitUserInfoListener.onSuccess()
                }
            } else {
                DispatchQueue.main.async {
                    submitUserInfoListener.onError()
                }
            }
        }
        task.resume()
    }
    
}
