//
//  ViewController.swift
//  AccuVax Mobile Portal
//
//  Created by Nathan Baker on 7/18/17.
//  Copyright © 2017 Nathan Baker. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        usernameTextField.returnKeyType = .next
        passwordTextField.returnKeyType = .done
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        if usernameTextField.text?.characters.count == 0 || passwordTextField.text?.characters.count == 0 {
            return
        }
        loadShit(user: usernameTextField.text!, password: passwordTextField.text!)
        
    }
    func nextViewController(initialArray: [Any]) {
        let storyBoard = UIStoryboard(name: "Main", bundle: .main)
        let newVC = storyBoard.instantiateViewController(withIdentifier: "selectKioskNavController") as! UINavigationController
        let childOne = newVC.childViewControllers[0] as! SelectMachineTableViewController
        childOne.currentArray = initialArray
        present(newVC, animated: true, completion: nil)
    }
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    func loadShit(user: String, password: String) {
        dismissKeyboard()
        Accuvax.email = user
        Accuvax.password = password
        var json: JSON!
        var headers: HTTPHeaders = [
            "Content-Type" : "application/json",
            ]
        if let authorizationHeader = Request.authorizationHeader(user: user, password: password) {
            headers[authorizationHeader.key] = authorizationHeader.value
        }
        Alamofire.request("https://accuvax-dev01.accuvax.com/api/connect/locations.json", headers: headers).authenticate(user: user, password: password).responseJSON { responseData in
            if let dict = responseData.result.value as? [String: Any] {
                json = JSON(dict)
                if json["error"][0].stringValue == "Unauthorized session" {
                    let errorAlert = UIAlertController(title: "Error", message: "Incorrect Email Password Combination.", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default)
                    errorAlert.addAction(ok)
                    self.present(errorAlert, animated: true, completion: nil)
                } else {
                    let locationsJSON = json["locations"].arrayValue
                    var vcTableViewArray = [Any]()
                    for locationJSON in locationsJSON {
                        vcTableViewArray.append(Location(locationJSON: locationJSON))
                    }
                    self.nextViewController(initialArray: vcTableViewArray)
                }
            }
        }
    }

}
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 1:
            passwordTextField.becomeFirstResponder()
            return false
            
        case 2:
            self.loadShit(user: usernameTextField.text!, password: passwordTextField.text!)
            return false
        default:
            usernameTextField.becomeFirstResponder()
            return false
            
        }
    }
}
