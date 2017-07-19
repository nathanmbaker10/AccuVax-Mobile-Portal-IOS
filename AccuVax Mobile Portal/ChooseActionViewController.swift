//
//  ChooseActionViewController.swift
//  AccuVax Mobile Portal
//
//  Created by Nathan Baker on 7/19/17.
//  Copyright © 2017 Nathan Baker. All rights reserved.
//

import UIKit

class ChooseActionViewController: UIViewController {
    @IBOutlet weak var userManagementButton: UIButton!
    @IBOutlet weak var temperatureButton: UIButton!
    @IBOutlet weak var inventoryButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setInsets()
        // Do any additional setup after loading the view.
    }
    func setInsets() {
        let inventoryInsets = UIEdgeInsetsMake(10, 10, 10, 10)
        let usermanagementInsets = UIEdgeInsetsMake(20, 20, 20, 20)
        let tempInsets = UIEdgeInsetsMake(25, 25, 25, 25)
        
        userManagementButton.imageEdgeInsets = usermanagementInsets
        temperatureButton.imageEdgeInsets = inventoryInsets
        inventoryButton.imageEdgeInsets = inventoryInsets
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
