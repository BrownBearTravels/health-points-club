//
//  HistoryTableViewController.swift
//  healthpoints
//
//  Created by Joseph Smith on 5/31/17.
//  Copyright © 2017 healthpoints. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: NSNotification.Name(rawValue: "updateUIFromHealthDay"), object: nil)
        
            self.tableView.tableFooterView = UIView()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let darkmodeOn = UserDefaults.standard.bool(forKey: "darkmodeOn")
        
        if darkmodeOn {
            enableDarkMode()
        } else {
            disableDarkMode()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return HealthDay.shared.history.count
    }
    
    
    func enableDarkMode() {
        view.backgroundColor = UIColor(red:0.24, green:0.25, blue:0.25, alpha:1.00)
        navigationController?.navigationBar.barTintColor = UIColor(red:0.14, green:0.15, blue:0.15, alpha:1.00)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.00)]
        tabBarController?.tabBar.barTintColor = UIColor(red:0.14, green:0.15, blue:0.15, alpha:1.00)
        tableView.backgroundColor = UIColor(red:0.24, green:0.25, blue:0.25, alpha:1.00)
        for cell in tableView.visibleCells {
            cell.backgroundColor = UIColor(red:0.24, green:0.25, blue:0.25, alpha:1.00)
            cell.textLabel?.textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.00)
            cell.detailTextLabel?.textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.00)
        }
    }
    
    func disableDarkMode() {
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.black]
        tabBarController?.tabBar.barTintColor = UIColor.white
        tableView.backgroundColor = UIColor.white
        for cell in tableView.visibleCells {
            cell.backgroundColor = UIColor.white
            cell.textLabel?.textColor = UIColor.black
            cell.detailTextLabel?.textColor = UIColor.black
        }
    }
    
    func updateUI() {
        DispatchQueue.main.async {
            
            self.tableView.reloadData()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        // Configure the cell...
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        
        cell.textLabel?.text = formatter.string(from: HealthDay.shared.history[indexPath.row].date)
        cell.detailTextLabel?.text = HealthDay.shared.history[indexPath.row].points.description
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
