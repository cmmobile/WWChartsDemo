//
//  L2ViewController.swift
//  WWChartsDemo
//
//  Created by cm0622 on 2020/6/15.
//  Copyright © 2020 cm0622. All rights reserved.
//

import UIKit
import Charts

class L3ViewController: UIViewController {
    
    @IBOutlet weak var chart: CombinedChartView!
    
    private var kDatas: [KLineData] = []
    private var lineDatas: [LineData] = []
    
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
    
    // MARK: - API Sample
    
    private func getLineData() {
        var datas: [LineData] = []
        for i in 1...5 {
            let number = Double(i) * 10
            let data = LineData(time: "\(i)月", price: number - 1)
            datas.append(data)
        }
        self.lineDatas = datas
    }
    
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
    
    private func setData() {
        let data = CombinedChartData()
        data.candleData = getCData()
        chart.data = data
    }
    
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
    
    // MARK: - Line
    
    // MARK: - Candle
    
    private func getCData() -> CandleChartData {
        var enties: [CandleChartDataEntry] = []
        for (i, data) in kDatas.enumerated() {
            let e = CandleChartDataEntry(x: Double(i), shadowH: data.high, shadowL: data.low, open: data.open, close: data.close)
            enties.append(e)
        }
        let set1 = setCDataSet(enties: enties)
        let cData = CandleChartData(dataSet: set1)
        return cData
    }
    
    private func setCDataSet(enties: [CandleChartDataEntry]) -> CandleChartDataSet {
        let dataset = CandleChartDataSet(entries: enties, label: nil)
        dataset.decreasingColor = .green
        dataset.increasingColor = .red
        dataset.decreasingFilled = true
        dataset.increasingFilled = true
        dataset.shadowColorSameAsCandle = true
        return dataset
    }
    
}

struct LineData {
    let time: String
    let price: Double
}
