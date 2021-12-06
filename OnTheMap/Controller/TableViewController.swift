//
//  TableViewController.swift
//  OnTheMap
//
//  Created by Ty Hopp on 4/12/21.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var navBarLogicController: NavBarLogicController?
    var tableCells = [StudentInformation]()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarLogicController = NavBarLogicController(self)
        fillTableView()
    }
    
    // MARK: Outlet
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    
    // MARK: Action
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        self.navBarLogicController?.handleLogoutButtonPress(logoutButton)
    }
    
    @IBAction func refreshButtonPressed(_ sender: Any) {
        self.navBarLogicController?.handleRefreshButtonPress(refreshButton, reload: fillTableView)
    }
    
    // MARK: Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentLocationTableCell") as! TableCellView
        let cellData = tableCells[(indexPath as NSIndexPath).row]
        
        cell.name.text = "\(cellData.firstName) \(cellData.lastName)"
        cell.mediaURL.text = cellData.mediaURL
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellData = tableCells[(indexPath as NSIndexPath).row]
        if let url = URL(string: cellData.mediaURL) {
            UIApplication.shared.open(url, completionHandler: { success in
                tableView.deselectRow(at: indexPath, animated: true)
                if !success {
                    self.showErrorAlert(title: "Failed to open URL", description: "Ensure that the URL is valid.")
                }
            })
        }
    }
    
    // MARK: Helper
    
    func fillTableView(completion: @escaping () -> Void = {}) -> Void {
        // In a real project we would share data with the map view and conditionally make network requests, but we'll consider it out of scope for this project
        
        UdacityClient.getStudentLocations(completion: { response, error in
            if let studentInfo = response?.results {
                self.tableCells = studentInfo
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            completion()
        })
    }
}
