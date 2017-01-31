//
//  StudentInfoStore.swift
//  OnTheMap
//
//  Created by Kushal Sharma on 31/01/17.
//  Copyright © 2017 Kushal. All rights reserved.
//

import Foundation
class StudentInfoStore {

    static let sharedInstace = StudentInfoStore()

    private init() {}
    
    func getStudentInfo(studentInfoListener: StudentInfoListener){
        let request = NSMutableURLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation")!)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil { // Handle error...
                studentInfoListener.onNetworkFailure(error: "")
                return
            }
            let response = response as! HTTPURLResponse
            let statusCode: Int = response.statusCode
            if statusCode >= 200 && statusCode <= 299 {
                let range = Range(uncheckedBounds: (5, data!.count))
                let newData = data?.subdata(in: range) /* subset response data! */
                let json = try? JSONSerialization.jsonObject(with: newData!, options: [])
                let studentInfo: StudentInfo = StudentInfo(json: json as! [String : Any])
                DispatchQueue.main.async {
                    studentInfoListener.onSuccess(data: studentInfo)
                }
            } else {
                studentInfoListener.onNetworkFailure(error: "")
            }
        }
        task.resume()
    }
}
