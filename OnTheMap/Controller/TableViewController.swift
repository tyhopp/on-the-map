//
//  TableViewController.swift
//  OnTheMap
//
//  Created by Ty Hopp on 4/12/21.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var navBarLogicController: NavBarLogicController?
    var tableCells = [TableCell]()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarLogicController = NavBarLogicController(self)
        fillTableView()
    }
    
    // MARK: Outlet
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    
    // MARK: Action
    
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
        
        cell.name.text = cellData.name
        cell.mediaURL.text = cellData.mediaURL
        
        // TODO - Style text
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO - Handle select
    }
    
    // MARK: Helper
    
    func fillTableView(completion: @escaping () -> Void = {}) -> Void {
        // In a real project we would share data with the map view and conditionally make network requests, but we'll consider it out of scope for this project
        
        UdacityClient.getStudentLocations(completion: { response, error in
            if let locations = response?.results {
                for location in locations {
                    let cell = TableCell(name: "\(location.firstName) \(location.lastName)", mediaURL: location.mediaURL)
                    self.tableCells.append(cell)
                }
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            completion()
        })
    }
}
