//
//  BarChartViewController.swift
//  graphic_test1
//
//  Created by Sumeet Dhakan on 11/27/17.
//  Copyright © 2017 livia. All rights reserved.
//

import UIKit
import Charts

class BarChartViewController: UIViewController {
    
    var months:[String] = []
    var temperature:[Double] = []
    var points:[Double] = []
    var dataEntries: [BarChartDataEntry] = []
    @IBOutlet weak var barChartView: BarChartView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Data Source
        months = ["Ja","Fe","Mar","Ap","May","Jun","July","Ago","Set","Oc","Nov","Dec"]
        temperature = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        // Call function chart_Creation to create a bar chart
        chart_Creation(x: months, y: temperature)
    }
    
    
    func chart_Creation(x: [String], y: [Double]) {
        barChartView.noDataText = "You need to provide data for the chart."
        barChartView.noDataText.append("\n Explain user why the chart is empty")
        barChartView.noDataText.append("\n Tell what they need to do in order to get data")
        
        for i in 0..<temperature.count {
            let dataEntry = BarChartDataEntry(x:Double(i), y: Double(temperature[i]))
            dataEntries.append(dataEntry)
            
        }
        let chart = BarChartDataSet(values: dataEntries, label: "Temperature")
        let chartData = BarChartData()
        chartData.addDataSet(chart)
        chartData.setDrawValues(true)
        chartData.setValueFont(UIFont(name: "Verdana", size: 14.0)!)
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values:months)
       // barChartView.xAxis.setLabelCount(months.count, force: true)
        barChartView.xAxis.labelFont = UIFont(name: "Verdana", size: 15.0)!
        barChartView.leftAxis.labelFont = UIFont(name: "Verdana", size: 15.0)!
        barChartView.legend.font = UIFont(name: "Verdana", size: 15.0)!
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.granularity = 1
        barChartView.chartDescription?.enabled = false
        barChartView.rightAxis.enabled = false
        barChartView.leftAxis.drawGridLinesEnabled = false
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        // Add limit line
        let limitLine = ChartLimitLine(limit: 10.0, label: "Temperature Threshold")
        barChartView.leftAxis.addLimitLine(limitLine)
        barChartView.data = chartData
        
    }
    
    
    @IBAction func savesChart(_ sender: UIBarButtonItem) {
        let img = barChartView.getChartImage(transparent: false)
        UIImageWriteToSavedPhotosAlbum(img!, nil, nil, nil)

       // let image = barChartView.save(to: "\(AppDelegate.getAppDelegate().getDocDir())/chart.jpeg", format: BarLineChartViewBase.ImageFormat.jpeg, compressionQuality: 1.0)
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
