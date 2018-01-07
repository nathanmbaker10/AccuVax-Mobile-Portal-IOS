
//
//  VaccineViewController.swift
//  AccuVax Mobile Portal
//
//  Created by Nathan Baker on 7/21/17.
//  Copyright © 2017 Nathan Baker. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class VaccineViewController: UIViewController {
    @IBOutlet weak var totalDosesRemainingLabel: UILabel!
    @IBOutlet weak var vaccineNameLabel: UILabel!
    @IBOutlet weak var lotTableView: UITableView!
    @IBOutlet weak var totalVialsLabel: UILabel!
    @IBOutlet weak var vaccineBrandNameLabel: UILabel!
    var visited = false
    var vaccine: Vaccine?
    var tag = -1
    var sections: [Section] = []
    var selectedIndexPath: IndexPath!
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        

//        insertInfo()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        insertInfo()
        visited = true
        self.parent?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func insertInfo() {
        if let vac = self.vaccine {
            self.totalVialsLabel.text = "Total Vials: " + String(describing: vac.totalCount)
            self.totalDosesRemainingLabel.text = "Total Doses Remaining: " + String(describing: vac.totalDosesRemaining)
            self.vaccineBrandNameLabel.text = "Brand Name: " + vac.brandName
            self.vaccineNameLabel.text = "Name: " + vac.name
            self.parent?.navigationItem.title = vac.brandName
            selectedIndexPath = IndexPath(row: -1, section: -1)
            if let vac = vaccine {
                if !visited {
                    sections = []
                    for lot in vac.lots {
                        sections.append(Section(lot: lot, expanded: false))
                    }
                }
            }
        let nib = UINib(nibName: "LotExpandableHeaderView", bundle: nil)
        lotTableView.register(nib, forHeaderFooterViewReuseIdentifier: "lotExpandableHeader")
//            self.parent?.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
//            self.parent?.navigationController?.navigationBar.backgroundColor = UIColor(red: 8, green: 150, blue: 172, alpha: 1)

        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension VaccineViewController: UITableViewDataSource, UITableViewDelegate, LotExpandableHeaderDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 58
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if sections[indexPath.section].expanded {
            return 150
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section != sections.count - 1 {
            return 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let vaccine = vaccine {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "lotExpandableHeader") as? LotExpandableHeader
            headerView?.customInit(lot: sections[section].lot, delegate: self, section: section)
            return headerView
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailedLot") as! ExpandedLotTableViewCell
        
        let currentLot = sections[indexPath.section].lot
        
        cell.vialCountLabel.text = "Vials: " + String(describing: currentLot.count)
        cell.dosesRemainingLabel.text = "Doses: " + String(describing: currentLot.dosesRemaining)
        cell.ownerLable.text = "Owner: " + currentLot.owner
        cell.productNDCLabel.text = "Product-NDC: " + currentLot.productNDC
        cell.packageNDCLabel.text = "Package-NDC: " + currentLot.packageNDC
        cell.programLabel.text = "Program: " + currentLot.program
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if vaccine != nil {
            self.selectedIndexPath = indexPath
            
        }
    }
    
    func toggleSection(header: LotExpandableHeader, section: Int) {
        sections[section].expanded = !sections[section].expanded
        lotTableView.beginUpdates()
        lotTableView.reloadSections([section], with: .fade)
        lotTableView.endUpdates()
    }
    
    @objc func refresh() {
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        self.parent?.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activityIndicator)
        activityIndicator.startAnimating()
        if let parent = self.parent as? InventoryPageViewController {
            parent.previousVC.loadVaccines(sendingFacility: Accuvax.current!.sendingFacility!, firstPage: self.tag) { vaccineDict in
                parent.vaccineDict = vaccineDict
                activityIndicator.stopAnimating()
                self.insertInfo()
                self.lotTableView.reloadData()
                self.parent?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.refresh))
            }
        }
    }
}

