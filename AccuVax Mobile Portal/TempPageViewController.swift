//
//  TempPageViewController.swift
//  AccuVax Mobile Portal
//
//  Created by Nathan Baker on 7/21/17.
//  Copyright © 2017 Nathan Baker. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TempPageViewController: UIPageViewController {
    var index: Int?
//    var childOne: TempViewController?
//    var childTwo: TempViewController?
    lazy var childArray: [TempViewController] = { [unowned self] in
        
        let result = [self.newChild(), self.newChild()]
        for vc in result {
            vc.tag = result.index(of: vc)
            vc.parentVC = self
        }
        return result
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dataSource = self
        view.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
//        loadTemperatures()
    }
    func styleIndicator() {
        self.view.backgroundColor = UIColor.white
//        let pageControl = UIPageControl.appearance(whenContainedInInstancesOf: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func newChild() -> TempViewController {
        return UIStoryboard(name: "Temperature", bundle: .main).instantiateViewController(withIdentifier: "tempVC") as! TempViewController
    }
    func setChildHistoriesNil() {
        for child in childArray {
            child.weekHistory = []
            child.dayHistory = []
        }
    }
    
    func loadTemperatures(sendingFacility: String, tagForFirst: Int?, completion: ((Void) -> Void)?) {
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
        var scopeLoopCount = 0
        setChildHistoriesNil()
        for scope in ["day", "week"] {
            Alamofire.request("https://accuvax-dev01.accuvax.com/api/connect/temperatures.json?scope=\(scope)&accuvax_name=\(Accuvax.current!.name)", headers: headers).authenticate(user: user, password: password).responseJSON { responseData in
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
                    let current = json?["accuvaxes"][0]
                    let historyArray = current?["history"].arrayValue
                    
                    for index in self.childArray.indices {
                        switch self.childArray[index].tag {
                        case 0:
                            self.childArray[index].current = Temperature(currentJSON: current!, type: .cold)
                            
                            for historyJSON in historyArray! {
                                if scopeLoopCount == 0 {
                                    self.childArray[index].dayHistory.append(Temperature(historyJSON: historyJSON, type: .cold)!)
                                } else {
                                    self.childArray[index].weekHistory.append(Temperature(historyJSON: historyJSON, type: .cold)!)
                                }
                            }
                            if scopeLoopCount == 0 {
                                self.childArray[index].dayHistory.append(self.childArray[index].current)
                            } else {
                                self.childArray[index].weekHistory.append(self.childArray[index].current)
                            }
                        case 1:
                            self.childArray[index].current = Temperature(currentJSON: current!, type: .frozen)
                            for historyJSON in historyArray! {
                                if scopeLoopCount == 0 {
                                    self.childArray[index].dayHistory.append(Temperature(historyJSON: historyJSON, type: .frozen)!)
                                } else {
                                    self.childArray[index].weekHistory.append(Temperature(historyJSON: historyJSON, type: .frozen)!)
                                }
                            }
                            if scopeLoopCount == 0 {
                                self.childArray[index].dayHistory.append(self.childArray[index].current)
                            } else {
                                self.childArray[index].weekHistory.append(self.childArray[index].current)
                            }
                        default:
                            break
                        }
                    }
                    scopeLoopCount += 1
                    if let first = self.childArray.first {
                        if scopeLoopCount == 2 {
                            if let tag = tagForFirst {
                                self.index = tag
                                self.setViewControllers([self.childArray[tag]], direction: .forward, animated: true, completion: nil)
                            } else {
                                self.setViewControllers([first], direction: .forward, animated: false, completion: nil)
                            }
                            if let completion = completion {
                                completion()
                            }
                        }
                    }
                   
                }
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
extension TempPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? TempViewController else { return nil }
        if currentVC.tag == 0 {
            return nil
        } else {
            return childArray[currentVC.tag - 1]
        }
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? TempViewController else { return nil }
        if currentVC.tag == 1 {
            return nil
        } else {
            return childArray[currentVC.tag + 1]
        }
    }
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return childArray.count
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        if let index = index {
            return index
        } else {
            return 0
        }
    }
    
}
