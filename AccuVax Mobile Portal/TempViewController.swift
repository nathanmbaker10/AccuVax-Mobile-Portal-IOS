//
//  TempViewController.swift
//  AccuVax Mobile Portal
//
//  Created by Nathan Baker on 7/20/17.
//  Copyright © 2017 Nathan Baker. All rights reserved.
//

import UIKit

class TempViewController: UIViewController {
    @IBOutlet weak var storageSystemLable: UILabel!
    var tag: Int!
    var parentVC: UIPageViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInfo()
        // Do any additional setup after loading the view.
    }
    func loadInfo() {
        switch self.tag {
        case 0:
            storageSystemLable.text = "Fridge"
        case 1:
            storageSystemLable.text = "Freezer"
        default:
            storageSystemLable.text = "nada"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
