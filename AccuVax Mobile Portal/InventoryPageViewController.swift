//
//  InventoryPageViewController.swift
//  AccuVax Mobile Portal
//
//  Created by Nathan Baker on 7/21/17.
//  Copyright © 2017 Nathan Baker. All rights reserved.
//

import UIKit

class InventoryPageViewController: UIPageViewController {
    var index = 0
    var didChange: Bool = false
    var childArray: [VaccineViewController] {
        let result = [newChild("Green"), newChild("Red"), newChild("Blue"), newChild("Orange")]
        for vc in result{
            vc.tag = result.index(of: vc)!
        }
        return result
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        if let first = childArray.first {
            setViewControllers([first], direction: .forward, animated: true, completion: nil)
        }
        // Do any additional setup after loading the view.
    }
    func newChild(_ color: String) -> VaccineViewController {
        return UIStoryboard(name: "Inventory", bundle: .main).instantiateViewController(withIdentifier: color) as! VaccineViewController
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
extension InventoryPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentVaccineVC = viewController as? VaccineViewController else {
            print("Failed the force downcast")
            return nil
        }
        if currentVaccineVC.tag == 0 {
            return nil
        } else {
            return childArray[currentVaccineVC.tag - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentVaccineVC = viewController as? VaccineViewController else {
            print("Failed the force downcast")
            return nil
        }
        if currentVaccineVC.tag == 3 {
            return nil
        } else {
            return childArray[currentVaccineVC.tag + 1]
        }
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 4
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}
