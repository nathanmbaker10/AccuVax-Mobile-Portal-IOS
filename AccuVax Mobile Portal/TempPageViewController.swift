//
//  TempPageViewController.swift
//  AccuVax Mobile Portal
//
//  Created by Nathan Baker on 7/21/17.
//  Copyright © 2017 Nathan Baker. All rights reserved.
//

import UIKit

class TempPageViewController: UIPageViewController {
    var index = 0
    var childArray: [TempViewController] {
        let result = [newChild(), newChild()]
        for vc in result {
            vc.tag = result.index(of: vc)
            vc.parentVC = self
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
        return 0
    }
    
}
