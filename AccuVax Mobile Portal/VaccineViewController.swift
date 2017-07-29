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
    @IBOutlet weak var lotCountLabel: UILabel!
    @IBOutlet weak var totalCountLabel: UILabel!
    @IBOutlet weak var vaccineBrandNameLabel: UILabel!
    @IBOutlet weak var vaccineNameLabel: UILabel!
    var vaccine: Vaccine?
    var tag = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        insertInfo()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func insertInfo() {
        if let vac = self.vaccine {
            self.totalCountLabel.text = String(describing: vac.totalCount)
            self.vaccineBrandNameLabel.text = vac.brandName
            self.vaccineNameLabel.text = vac.name
            self.lotCountLabel.text = String(describing: vac.lots?.count)
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
