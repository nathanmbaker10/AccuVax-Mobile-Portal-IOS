//
//  ChooseActionViewController.swift
//  AccuVax Mobile Portal
//
//  Created by Nathan Baker on 7/19/17.
//  Copyright © 2017 Nathan Baker. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ChooseActionViewController: UIViewController {
    @IBOutlet weak var currentMachineLocation: UILabel!
    @IBOutlet weak var currentMachineLabel: UILabel!
    @IBOutlet weak var temperatureButton: UIButton!
    @IBOutlet weak var inventoryButton: UIButton!
    var formerViewController: UIViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        setInsets()
//        testAPI()
        
        currentMachineLabel.text = (Accuvax.current?.name)!
        currentMachineLocation.text = (Accuvax.current?.location)!
        // Do any additional setup after loading the view.
    }
    func setInsets() {
        let inventoryInsets = UIEdgeInsetsMake(20, 20, 20, 20)
        temperatureButton.imageEdgeInsets = inventoryInsets
        inventoryButton.imageEdgeInsets = inventoryInsets
    }
    @IBAction func signOutButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.formerViewController.navigationController?.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func changeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true) {
            if let navController = self.formerViewController.navigationController {
                navController.popToViewController(navController.childViewControllers[0], animated: true)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func userManagementButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "goToUserManagement", sender: self)
    }
    @IBAction func inventoryButtonPressed(_ sender: Any) {
        let navVC = UIStoryboard(name: "Inventory", bundle: .main).instantiateViewController(withIdentifier: "inventoryNavController") as! UINavigationController
        
        if let sendingFacility = Accuvax.current?.sendingFacility {
            self.present(navVC, animated: true, completion: nil)
        } else {
            let errorAlert = UIAlertController(title: "Machine Monitoring not Enabled", message: "Your machine isn't confiugured to be monitored on this mobile platform. If you would like to be able to view Accuvax information on your IOS device, ask your administrator to configure a sending facility.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default)
            errorAlert.addAction(ok)
            self.present(errorAlert, animated: true, completion: nil)
        }

    }
    @IBAction func temperatureButtonPressed(_ sender: Any) {
        let pageVC = UIStoryboard(name: "Temperature", bundle: .main).instantiateViewController(withIdentifier: "temperaturePageVC") as! TempPageViewController
        
        if let sendingFacility = Accuvax.current?.sendingFacility {
            pageVC.loadTemperatures(sendingFacility: sendingFacility)
            self.present(pageVC, animated: true, completion: nil)
        } else {
            let errorAlert = UIAlertController(title: "Machine Monitoring not Enabled", message: "Your machine isn't confiugured to be monitored on this mobile platform. If you would like to be able to view Accuvax information on your IOS device, ask your administrator to configure a sending facility.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default)
            errorAlert.addAction(ok)
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) {_ in
                self.present(errorAlert, animated: true, completion: nil)
            }
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
