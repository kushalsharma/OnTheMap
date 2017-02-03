//
//  TableController.swift
//  OnTheMap
//
//  Created by Kushal Sharma on 31/01/17.
//  Copyright © 2017 Kushal. All rights reserved.
//

import UIKit

class TableController: UIViewController, UITableViewDelegate, UITableViewDataSource, StudentInfoListener {
    
    let cellReuseIdentifier = "tableCell"
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
        StudentInfoStore.sharedInstace.getStudentInfo(studentInfoListener: self)
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentInfoStore.sharedInstace.studentInfoList.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? StudentInfoTableViewCell else {
            fatalError("The cell is not an instance of StudentInfoTableViewCell")
        }
        
        cell.studentNameLabel.text = StudentInfoStore.sharedInstace.studentInfoList[indexPath.row].firstName
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index: Int = indexPath.row
        UIApplication.shared.open(NSURL(string: StudentInfoStore.sharedInstace.studentInfoList[index].mediaURL) as! URL, options: [:], completionHandler: nil)
    }
    
    func onSuccess(studentInfoList: [StudentInfo]) {
        myTableView.reloadData()
    }
    
    func onNetworkFailure(error: Any) {
        
    }
}
