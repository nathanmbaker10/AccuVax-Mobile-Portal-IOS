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
    @IBOutlet weak var lotTableView: UITableView!
    @IBOutlet weak var lotCountLabel: UILabel!
    @IBOutlet weak var totalCountLabel: UILabel!
    @IBOutlet weak var vaccineBrandNameLabel: UILabel!
    var vaccine: Vaccine?
    var tag = -1
    var sections: [Section] = []
    var selectedIndexPath: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndexPath = IndexPath(row: -1, section: -1)
        if let vac = vaccine {
            for lot in vac.lots {
                sections.append(Section(lot: lot, expanded: false))
            }
        }
        let nib = UINib(nibName: "LotExpandableHeader", bundle: nil)
        lotTableView.register(nib, forCellReuseIdentifier: "lotExpandableHeader")
//        insertInfo()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        insertInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func insertInfo() {
        if let vac = self.vaccine {
            self.totalCountLabel.text = "Doses Remaining: " + String(describing: vac.totalDosesRemaining)
//            self.vaccineBrandNameLabel.text = vac.name
            self.parent?.navigationItem.title = vac.brandName
            self.lotCountLabel.text = "Lot Count: " + String(describing: vaccine?.lots.count)
        }
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        self.parent?.dismiss(animated: true, completion: nil)
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
        if let vac = vaccine {
            return vac.lots.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 58
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if sections[indexPath.section].expanded {
            return 100
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let vaccine = vaccine {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "lotExpandableHeader") as? LotExpandableHeader
            headerView?.customInit(lot: vaccine.lots[section], delegate: self, section: section)
            return headerView
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailedLot")
        cell?.textLabel?.text = sections[indexPath.section].lot.lotCode
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if vaccine != nil {
            self.selectedIndexPath = indexPath
            
        }
    }
    
    func toggleSection(header: LotExpandableHeader, section: Int) {
        sections[section].expanded = !sections[section].expanded
        lotTableView.beginUpdates()
        lotTableView.reloadSections([section], with: .automatic)
        lotTableView.endUpdates()
    }
}

