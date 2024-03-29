//
//  InventoryPageViewController.swift
//  AccuVax Mobile Portal
//
//  Created by Nathan Baker on 7/21/17.
//  Copyright © 2017 Nathan Baker. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class InventoryPageViewController: UIPageViewController {
    var previousVC: InventoryTableViewController! = nil
    var index = 0
    var vaccineDict = [VaccineBrandName : Vaccine]() {
        didSet {
            for vc in getChildArray() {
                var didSet = false
                for i in vaccineDict.keys {
                    if vc.vaccine?.name == vaccineDict[i]?.name {
                        vc.vaccine = vaccineDict[i]
                        didSet = true
                    }
                }
                if !didSet {
                    vc.vaccine = nil
                }
            }
        }
    }
    var count = 0
    var childArray: [VaccineViewController]?
    func getChildArray() -> [VaccineViewController] {
        if let childArray = self.childArray {
            return childArray
        }
        var result = [VaccineViewController]()
        var currentTag = 0

        for vaccine in vaccineDict.values {
            let newVC = newChild()
            newVC.vaccine = vaccine
            newVC.tag = currentTag
            result.append(newVC)
            currentTag += 1
        }
        self.childArray = result
        return result
    }
//    {
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        dataSource = self
        
        self.setViewControllers([getChildArray()[index]], direction: .forward, animated: true, completion: nil)
//        loadVaccines()
        // Do any additional setup after loading the view.
    }
    func newChild() -> VaccineViewController {
        return UIStoryboard(name: "Inventory", bundle: .main).instantiateViewController(withIdentifier: "realVC") as! VaccineViewController
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        //corrects scrollview frame to allow for full-screen view controller pages
        for subView in self.view.subviews {
            if subView is UIScrollView {
                subView.frame = self.view.bounds
            }
        }
        super.viewDidLayoutSubviews()
    }
    /*
    func loadVaccines(sendingFacility: String) {
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
        
      
        Alamofire.request("https://accuvax-dev01.accuvax.com/api/connect/inventories.json?accuvax_name=\(Accuvax.current!.name)", headers: headers).authenticate(user: user, password: password).responseJSON { responseData in
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
                for lotJSON in lotsJSON! {
                    let lot = Lot(inventoryJSON: lotJSON)
                    let currentVacName = VaccineBrandName(rawValue: lot.brand_name)
                    if let vaccine = self.vaccineDict[currentVacName!] {
                        vaccine.lots?.append(lot)
                        vaccine.totalDosesRemaining += lot.dosesRemaining
                        vaccine.totalCount += lot.count
                    } else {
                        self.vaccineDict[currentVacName!] = Vaccine(brandName: currentVacName!, initialLot: lot)
                    }
                }
                if let first = self.childArray.first {
                    self.setViewControllers([first], direction: .forward, animated: true, completion: nil)
                }
            }
        }

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
extension InventoryPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentVaccineVC = viewController as? VaccineViewController else {
            print("Failed the force downcast")
            return nil
        }
        if currentVaccineVC.tag == 0 {
            return nil
        } else {
            return getChildArray()[currentVaccineVC.tag - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentVaccineVC = viewController as? VaccineViewController else {
            print("Failed the force downcast")
            return nil
        }
        if currentVaccineVC.tag == self.getChildArray().count - 1 {
            return nil
        } else {
            return getChildArray()[currentVaccineVC.tag + 1]
        }
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return getChildArray().count
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return index
        
    }
    
}
