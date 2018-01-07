//
//  LaunchScreenViewController.swift
//  AccuVax Mobile Portal
//
//  Created by Nathan Baker on 8/11/17.
//  Copyright © 2017 Nathan Baker. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()



        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let savedUsername = UserDefaults.standard.object(forKey: "rememberedUser") as? String{
            let savedPassword = UserDefaults.standard.object(forKey: "rememberedPassword") as! String
            let storyBoard = UIStoryboard(name: "Main", bundle: .main)
            let nextVC = storyBoard.instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
            nextVC.loadShit(user: savedUsername, password: savedPassword, sender: self)
            
        } else {
            self.performSegue(withIdentifier: "custom", sender: self)
        }

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
