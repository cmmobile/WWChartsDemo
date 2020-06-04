//
//  L1ViewController.swift
//  WWChartsDemo
//
//  Created by cm0622 on 2020/6/4.
//  Copyright © 2020 cm0622. All rights reserved.
//

import UIKit
import Charts

class L1ViewController: UIViewController {
    
    @IBOutlet weak var chart: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChart()
        setData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func setupChart() {
        chart.noDataFont = UIFont.boldSystemFont(ofSize: 20)
        chart.noDataText = "圖表無資料"
        chart.noDataTextColor = .white
        
        // 1.關閉圖示
        chart.legend.enabled = false
        
        // 2.x軸設定
        let xAxis = chart.xAxis
        xAxis.labelPosition = .bottom

        xAxis.labelCount = 6
        xAxis.labelTextColor = .white
        xAxis.labelFont = UIFont.systemFont(ofSize: 10)
        
        xAxis.axisLineColor = .yellow
//        xAxis.drawAxisLineEnabled = true
//        xAxis.axisLineWidth = 0.5
        
        xAxis.gridColor = .red
//        xAxis.drawGridLinesEnabled = true
//        xAxis.gridLineWidth = 0.5
        
        xAxis.axisMinimum = -10
        xAxis.axisMaximum = 10
    }
    
    private func setData() {
        var enties: [ChartDataEntry] = []
        for i in 1...5 {
            let e = ChartDataEntry(x: Double(i), y: Double(i))
            enties.append(e)
        }
        let set1 = LineChartDataSet(entries: enties, label: "資料1")
        
        enties = []
        var index = -3
        for i in 101...102 {
            let e = ChartDataEntry(x: Double(index), y: Double(i))
            index += 1
            enties.append(e)
        }
        let set2 = LineChartDataSet(entries: enties, label: "資料2")
        set2.axisDependency = .right
        
        let data = LineChartData(dataSets: [set1, set2])
        
        chart.data = data
    }
    
    @IBAction func clear(_ sender: Any) {
        chart.clear()
    }
    
}
