//
//  InventoryTableViewController.swift
//  AccuVax Mobile Portal
//
//  Created by Nathan Baker on 8/2/17.
//  Copyright © 2017 Nathan Baker. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class InventoryTableViewController: UITableViewController {
 var vaccineDict = [VaccineBrandName: Vaccine]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    func loadVaccines(sendingFacility: String, firstPage: Int?, completion: (([VaccineBrandName: Vaccine])->(Void))?) {
        var json: JSON?
        let user: String = Accuvax.email!
        let password: String = Accuvax.password!
        var headers: HTTPHeaders = [
            "Content-Type" : "application/json",
            "X-ACCUVAX-CONNECT-SENDING-FACILITY" : sendingFacility
        ]
        if let authorizationHeader = Request.authorizationHeader(user: user, password: password) {
            headers[authorizationHeader.key] = authorizationHeader.value
        }
        guard var nameForRequest = Accuvax.current?.name else {
            return
        }
        nameForRequest = nameForRequest.replacingOccurrences(of: " ", with: "&")
        
        Alamofire.request("https://accuvax-dev01.accuvax.com/api/connect/inventories.json?accuvax_name=\(nameForRequest)", headers: headers).responseJSON { responseData in
            if responseData.error != nil {
                let errorAlert = UIAlertController(title: "Server Connection Error", message: "There was an error connecting to the server or machine. Maybe check your internet connection.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default) {_ in
                    self.dismiss(animated: true, completion: nil)
                }
                errorAlert.addAction(ok)
                self.present(errorAlert, animated: true, completion: nil)
            }
            if let dict = responseData.result.value as? [String: Any] {
                json = JSON(dict)
                let lotsJSON = json?["inventories"].arrayValue
                var vacDict = [VaccineBrandName: Vaccine]()
                for lotJSON in lotsJSON! {
                    let lot = Lot(inventoryJSON: lotJSON)
                    let currentVacName = VaccineBrandName(rawValue: lot.brand_name)
                    if let vaccine = vacDict[currentVacName!] {
                        vaccine.lots.append(lot)
                        vaccine.totalDosesRemaining += lot.dosesRemaining
                        vaccine.totalCount += lot.count
                    } else {
                        vacDict[currentVacName!] = Vaccine(brandName: currentVacName!, initialLot: lot)
                    }
                }
                self.vaccineDict = vacDict
                if let completion = completion {
                    completion(self.vaccineDict)
                }
            }
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
        return vaccineDict.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "vaccineTableViewCell", for: indexPath) as! VaccineTableViewCell
        
        let nameArray = Array(vaccineDict.keys)
        cell.vaccineNameLabel.text = nameArray[indexPath.row].rawValue

        // Configure the cell...

        return cell
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        let activityIndictor = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activityIndictor)
        activityIndictor.startAnimating()
        self.loadVaccines(sendingFacility: Accuvax.current!.sendingFacility!, firstPage: nil) { vaccineDict in
            let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.refreshButtonTapped(_:)))
            activityIndictor.stopAnimating()
            self.navigationItem.rightBarButtonItem = refreshButton
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pageVC = UIStoryboard(name: "Inventory", bundle: .main).instantiateViewController(withIdentifier: "inventoryPageVC") as? InventoryPageViewController
        if let pageVC = pageVC {
            pageVC.vaccineDict = self.vaccineDict
            pageVC.index = indexPath.row
            pageVC.previousVC = self
            self.show(pageVC, sender: self)
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
