//
//  L2ViewController.swift
//  WWChartsDemo
//
//  Created by cm0622 on 2020/6/15.
//  Copyright © 2020 cm0622. All rights reserved.
//

import UIKit
import Charts

class L2ViewController: UIViewController {
    
    @IBOutlet weak var chart: CandleStickChartView!
    
    private var kDatas: [KLineData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getKlineData()
        setupChart()
        setData()
        setDateLine()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func setupChart() {
        // 1.關閉圖示
        chart.legend.enabled = false
        
        // 2.x軸設定
        let xAxis = chart.xAxis
        xAxis.labelPosition = .bottom
        xAxis.drawLabelsEnabled = false
        
        xAxis.drawGridLinesEnabled = false
        
    }
    
    // MARK: - API
    
    private func getKlineData() {
        var datas: [KLineData] = []
        for i in 1...5 {
            let number = Double(i) * 10
            let data = KLineData(time: "\(i)月", open: number, high: number + 2, low: number - 2, close: number + 2)
            datas.append(data)
        }
        self.kDatas = datas
    }
    
    // MARK: - update Charts
    
    private func setDateLine() {
        for (i, info) in kDatas.enumerated() {
            addDateLimitLine(month: info.time, index: i)
        }
    }
    
    ///增加限制線(月線)
    private func addDateLimitLine(month: String, index: Int) {
        let monthLimitLine = ChartLimitLine(limit: Double(index), label: month)
        monthLimitLine.labelPosition = .bottomLeft
        monthLimitLine.lineWidth = 1
        monthLimitLine.lineColor = .white
        monthLimitLine.valueTextColor = .white
        chart.xAxis.addLimitLine(monthLimitLine)
    }
    
    // MARK: - Set Data
    
    private func setData() {
        var enties: [CandleChartDataEntry] = []
        for (i, data) in kDatas.enumerated() {
            let e = CandleChartDataEntry(x: Double(i), shadowH: data.high, shadowL: data.low, open: data.open, close: data.close)
            enties.append(e)
        }
        let set1 = setDataSet(enties: enties)
        let data = CandleChartData(dataSet: set1)
        
        chart.data = data
    }
    
    private func setDataSet(enties: [CandleChartDataEntry]) -> CandleChartDataSet {
        let dataset = CandleChartDataSet(entries: enties, label: nil)
        dataset.decreasingColor = .green
        dataset.increasingColor = .red
        dataset.decreasingFilled = true
        dataset.increasingFilled = true
        dataset.shadowColorSameAsCandle = true
        return dataset
    }
    
}

struct KLineData {
    let time: String
    let open: Double
    let high: Double
    let low: Double
    let close: Double
}
