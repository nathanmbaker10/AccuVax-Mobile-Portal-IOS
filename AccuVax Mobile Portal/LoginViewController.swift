//
//  ViewController.swift
//  AccuVax Mobile Portal
//
//  Created by Nathan Baker on 7/18/17.
//  Copyright © 2017 Nathan Baker. All rights reserved.
//

import UIKit

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
        nextViewController()
    }
    func nextViewController() {
        let storyBoard = UIStoryboard(name: "Main", bundle: .main)
        let newVC = storyBoard.instantiateViewController(withIdentifier: "selectKioskNavController")
        present(newVC, animated: true, completion: nil)
    }
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 1:
            passwordTextField.becomeFirstResponder()
            return false
            
        case 2:
            nextViewController()
            return false
        default:
            usernameTextField.becomeFirstResponder()
            return false
            
        }
    }
}
