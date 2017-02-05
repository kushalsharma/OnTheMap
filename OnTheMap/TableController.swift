//
//  TableController.swift
//  OnTheMap
//
//  Created by Kushal Sharma on 31/01/17.
//  Copyright © 2017 Kushal. All rights reserved.
//

import UIKit

class TableController: UIViewController, UITableViewDelegate, UITableViewDataSource, StudentInfoListener, SessionInfoListener {
    
    let cellReuseIdentifier = "tableCell"
    @IBOutlet weak var myTableView: UITableView!
    var alertView: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertView = getLoadingAlert()
        
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
    @IBAction func logoutButtonClicked(_ sender: UIBarButtonItem) {
        present(alertView, animated: true, completion: nil)
        SessionStore.sharedInstace.makeLogoutRequest(sessionInfoListener: self)
    }
    @IBAction func createNewPostClicked(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "createNewPost_", sender: self)
    }
    
    func onSuccess(data: SessionInfo) {
        alertView.dismiss(animated: true, completion: nil)
        dismiss(animated: true, completion: nil)
    }
    
    func onIncorrectCredentials() {
        // Nothing to do here
    }
    
    func getLoadingAlert() -> UIViewController {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        alert.view.tintColor = UIColor.black
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50,height: 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        return alert
    }
}
