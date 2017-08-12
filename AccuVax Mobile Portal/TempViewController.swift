//
//  TempViewController.swift
//  AccuVax Mobile Portal
//
//  Created by Nathan Baker on 7/20/17.
//  Copyright © 2017 Nathan Baker. All rights reserved.
//

import UIKit
import Charts

class TempViewController: UIViewController, ChartViewDelegate {
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var lineChart: LineChartView!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    var tag: Int!
    var parentVC: TempPageViewController?
    var min: Temperature! = nil
    var max: Temperature! = nil
    var current: Temperature! = nil
    var dayHistory: [Temperature] = []
    var weekHistory: [Temperature] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineChart.delegate = self
        findMinMax()
        loadInfo()
        // Do any additional setup after loading the view.
    }
    func findMinMax() {
        min = dayHistory[0]
        max = dayHistory[0]
        for TemperatureObject in dayHistory {
            if TemperatureObject.temp < min.temp {
                min = TemperatureObject
            }
            if TemperatureObject.temp > max.temp {
                max = TemperatureObject
            }
        }
    }
    
    func loadInfo() {
        lineChart.xAxis.axisMinimum = 0
        lineChart.xAxis.axisMaximum = Double(weekHistory.count)
//        lineChart.isUserInteractionEnabled = false
        
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<weekHistory.count {
            let data = ChartDataEntry(x: Double(i), y: weekHistory[i].temp)
            dataEntries.append(data)
        }
        let chartDataSet = LineChartDataSet(values: dataEntries, label: nil)
//        chartDataSet.circleColors = [NSUIColor.black]
        chartDataSet.highlightEnabled = false
        chartDataSet.colors = [NSUIColor(red: 0.05490196, green: 0.6745098, blue: 0.78039216, alpha: 1)]
//        chartDataSet.colors = [NSUIColor(red: 1, green: 0.82568627, blue: 0.01568627, alpha: 1)]
        chartDataSet.axisDependency = .left
        chartDataSet.drawCirclesEnabled = false
        
        lineChart.legend.textColor = UIColor.white
        lineChart.chartDescription?.text = ""
        switch self.tag {
        case 0:
            self.navigationBar.topItem?.title = "Refrigerator"
            chartDataSet.label = "Fridge Temp"
            lineChart.leftAxis.axisMinimum = 0
            lineChart.leftAxis.axisMaximum = 10
            lineChart.rightAxis.axisMinimum = 0
            lineChart.rightAxis.axisMaximum = 10
        case 1:
            self.navigationBar.topItem?.title = "Freezer"
            chartDataSet.label = "Freezer Temp"
            lineChart.leftAxis.axisMinimum = -24
            lineChart.leftAxis.axisMaximum = -18
            lineChart.rightAxis.axisMinimum = -24
            lineChart.rightAxis.axisMaximum = -18
            
        default: break
        }
        currentTempLabel.text = String(describing: current.temp) + " °C"
        minTempLabel.text = String(describing: min.temp) + " °C"
        maxTempLabel.text = String(describing: max.temp) + " °C"
        
        

        
        let chartData = LineChartData(dataSet: chartDataSet)
        lineChart.data = chartData
        lineChart.legend.entries[0].formColor = NSUIColor(red: 0.05490196, green: 0.6745098, blue: 0.78039216, alpha: 1)
        lineChart.drawGridBackgroundEnabled = false
        lineChart.xAxis.labelTextColor = UIColor(red: 51, green: 51, blue: 51, alpha: 0)
        lineChart.xAxis.labelPosition = .bottom
        lineChart.xAxis.drawGridLinesEnabled = false
        lineChart.leftAxis.drawGridLinesEnabled = false
        lineChart.rightAxis.drawGridLinesEnabled = false
        lineChart.rightAxis.labelTextColor = UIColor(red: 51, green: 51, blue: 51, alpha: 0)
        lineChart.leftAxis.labelTextColor = UIColor.white
        
        
        lineChart.animate(xAxisDuration: 1.0)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.parent?.dismiss(animated: true, completion: nil)
    }

    @IBAction func refreshButtonTapped(_ sender: Any) {
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        self.navigationBar.topItem?.rightBarButtonItem?.customView = activityIndicator
        activityIndicator.startAnimating()
        
        if let sendingFacility = Accuvax.current?.sendingFacility {
            self.parentVC?.loadTemperatures(sendingFacility: sendingFacility, tagForFirst: self.tag, completion: {
                self.loadInfo()
                let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.refreshButtonTapped(_:)))
                self.navigationBar.topItem?.rightBarButtonItem = refreshButton
                activityIndicator.stopAnimating()
            })
            
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
