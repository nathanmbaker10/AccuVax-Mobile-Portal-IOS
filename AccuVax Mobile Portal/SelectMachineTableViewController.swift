//
//  SelectMachineTableViewController.swift
//  AccuVax Mobile Portal
//
//  Created by Nathan Baker on 7/18/17.
//  Copyright © 2017 Nathan Baker. All rights reserved.
//

import UIKit

class SelectMachineTableViewController: UITableViewController {
    var tag: Int = 1
    var locations = [String]()
    var kioskGroups = [String]()
    var kiosks = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch tag {
        case 1:
            navigationItem.title = "Your Locations"
            navigationItem.leftBarButtonItem?.title = "Sign Out"
        case 2:
            navigationItem.title = "Available Kiosk Groups"
            navigationItem.leftBarButtonItem?.title = "Back"
        case 3:
            navigationItem.title = "Available Machines"
            navigationItem.leftBarButtonItem?.title = "Back"
        default:
            navigationItem.title = "random"
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        switch tag {
        case 1:
//            return locations.count
            return 10
        case 2:
//            return kioskGroups.count
            return 10
        case 3:
//            return kiosks.count
            return 10
        default:
            return 10
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tag {
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as? LocationTableViewCell
            cell?.locationLabel.text = "Location"
            return cell!
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "kioskGroupCell", for: indexPath) as? KioskGroupTableViewCell
            cell?.kioskGroupLabel.text = "Kiosk Group"
            return cell!
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "kioskCell", for: indexPath) as? KioskTableViewCell
            cell?.kioskLabel.text = "Machine"
            return cell!
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as? LocationTableViewCell
            cell?.locationLabel.text = "Random"
            return cell!
        }


        // Configure the cell..
    }
    func newSelf() {
        let storyBoard = UIStoryboard(name: "Main", bundle: .main)
        let newVC = storyBoard.instantiateViewController(withIdentifier: "tableView") as! SelectMachineTableViewController
        newVC.tag = self.tag + 1
        self.show(newVC, sender: self)
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedIndex = tableView.indexPathForSelectedRow {
            let cell = self.tableView.cellForRow(at: selectedIndex)
                                cell?.setSelected(false, animated: true)
            cell?.accessoryType = .none

        }
            
        
        self.tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let selectedIndex = tableView.indexPathForSelectedRow {
            let cell = self.tableView.cellForRow(at: selectedIndex)
            cell?.setSelected(false, animated: true)
            cell?.accessoryType = .none
            
        }
        return indexPath
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        if tag == 1 {
            self.dismiss(animated: true, completion: nil)
        } else {
        self.navigationController?.popViewController(animated: true)
        }
    }

    @IBAction func nextButtonTapped(_ sender: UIBarButtonItem) {
        if self.tableView.indexPathForSelectedRow != nil {
                switch tag {
                case 1:
                    newSelf()
                case 2:
                    newSelf()
                case 3:
                    let storyBoard = UIStoryboard(name: "Main", bundle: .main)
                    let newVC = storyBoard.instantiateViewController(withIdentifier: "rando")
                    self.show(newVC, sender: self)
                default: break
            }
        }
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
