//
//  LaunchScreenViewController.swift
//  AccuVax Mobile Portal
//
//  Created by Nathan Baker on 8/11/17.
//  Copyright © 2017 Nathan Baker. All rights reserved.
//

import UIKit
import Motion

class LaunchScreenViewController: UIViewController {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.isMotionEnabled = true


        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.performSegue(withIdentifier: "custom", sender: self)
//        contentView.motionIdentifier = "logo"
//        
//        logoImageView.isMotionEnabled = true
//        logoImageView.motionIdentifier = "image"
//        let loginVC = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
//        self.present(loginVC, animated: true, completion: nil)
        //        logoImageView.transition([.forceAnimate])
//        contentView.transition([.forceAnimate])
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
