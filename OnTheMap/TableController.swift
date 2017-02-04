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
        let url: String = StudentInfoStore.sharedInstace.studentInfoList[index].mediaURL
        if(verifyUrl(urlString: url)) {
            UIApplication.shared.open(NSURL(string: url) as! URL, options: [:], completionHandler: nil)
        } else {
            showAlert(title: "Bad Url", message: "Cannot open the link, something went wrong.", actionTitle: "Okay")
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func onSuccess(studentInfoList: [StudentInfo]) {
        myTableView.reloadData()
    }
    
    func onNetworkFailure(error: Any) {
        showAlert(title: "Error",message: "Something went wrong", actionTitle: "Okay")
    }
    
    func showAlert(title: String, message: String, actionTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default) { action in
            // perhaps use action.title here
        })
        present(alert, animated: true, completion: nil)
    }
    
    func verifyUrl (urlString: String?) -> Bool {
        //Check for nil
        if let urlString = urlString {
            // create NSURL instance
            if let url = NSURL(string: urlString) {
                // check if your application can open the NSURL instance
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
}
