//
//  ChartViewController.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2021/07/21.
//

import UIKit
import Charts
import RealmSwift

class ChartViewController: UIViewController {
    @IBOutlet var barChartView: BarChartView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let realm = try! Realm()

            // 全データ検索
            let results = realm.objects(StudyRecord.self)
            print(results)
            
            
            let rawData: [Int] = [20, 50, 70, 30, 60, 90, 40]
            //たとえば一番最初は20だから全部20ずつ合計で20×３で60になる
            let entries = rawData.enumerated().map { BarChartDataEntry(x: Double($0.offset), yValues: [Double($0.element), Double($0.element), Double($0.element)]) }
            let dataSet = BarChartDataSet(entries: entries)
            let data = BarChartData(dataSet: dataSet)
            barChartView.data = data
            
            // X軸のラベルの位置を下に設定
            barChartView.xAxis.labelPosition = .bottom
            // X軸のラベルの色を設定
            barChartView.xAxis.labelTextColor = .systemGray
            // X軸の線、グリッドを非表示にする
            barChartView.xAxis.drawGridLinesEnabled = false
            barChartView.xAxis.drawAxisLineEnabled = false
            
            barChartView.rightAxis.enabled = false
            
            // Y座標の値が0始まりになるように設定
            barChartView.leftAxis.axisMinimum = 0.0
            barChartView.leftAxis.drawZeroLineEnabled = true
            barChartView.leftAxis.zeroLineColor = .systemGray
            // ラベルの数を設定
            barChartView.leftAxis.labelCount = 5
            // ラベルの色を設定
            barChartView.leftAxis.labelTextColor = .systemGray
            // グリッドの色を設定
            barChartView.leftAxis.gridColor = .systemGray
            // 軸線は非表示にする
            barChartView.leftAxis.drawAxisLineEnabled = false
            
            barChartView.legend.enabled = false
            
            dataSet.drawValuesEnabled = false
            dataSet.colors = [#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)]
            
            // 平均
            let avg = rawData.reduce(0) { return $0 + $1 } / rawData.count
            let limitLine = ChartLimitLine(limit: Double(avg))
            limitLine.lineColor = .systemOrange
            limitLine.lineDashLengths = [4]
            barChartView.leftAxis.addLimitLine(limitLine)
        }
}
