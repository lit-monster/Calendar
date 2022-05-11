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
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    let realm = try! Realm()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        let realm = try! Realm()
        //
        //        // 全データ検索
        //        let results = realm.objects(StudyRecord.self)
        //        print(results)
        
        //            viewload時に選択されているボタン
        segmentedControl.selectedSegmentIndex = 0
        
        
        //            var date = results.filter {
        //                $0.date > Range
        //            }
        
        //            {
        //            quality1 mount = date.filter{
        //                quality = 1
        //            }
        //            }
        
        let rawData: [Int] = [20, 50, 70, 30, 60, 90, 40]
        //たとえば一番最初は20だから全部20ずつ合計で20×３で60になる
        let entries = rawData.enumerated().map { BarChartDataEntry(x: Double($0.offset), yValues: [Double($0.element), Double($0.element), Double($0.element)]) }
        
        
        getWeekData()
    }
    
    //    選択されたボタンのタイトルを取得する
    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        print(sender.titleForSegment(at: sender.selectedSegmentIndex)!)
    }
    
    func pickStudyRecordData(range: String) -> [[Int]] {
        
        
        switch range {
        case "W":
            getWeekData()
        case "M":
            getMonthData()
        case "3M":
            get3MonthData()
        case "6M":
            get6MonthData()
        default:
            break
        }
        
        
        
        func getMonthData() {
            
        }
        
        func get3MonthData() {
            
        }
        
        func get6MonthData() {
            
        }
        //dummy
        return [[30, 40, 50], [60,30,20], [10,3,40], [40, 20, 0], [30, 0, 35], [20, 20, 20], [20, 10, 40]]
    }
    
    func getWeekData() {
        let results = realm.objects(StudyRecord.self)
        print(results)
        
        let weekAgo = Date(timeIntervalSinceNow: -60*60*24*7)
        let sixDaysAgo = Date(timeIntervalSinceNow: -60*60*24*6)
        let fiveDaysAgo = Date(timeIntervalSinceNow: -60*60*24*5)
        let fourDaysAgo = Date(timeIntervalSinceNow: -60*60*24*4)
        let threeDaysAgo = Date(timeIntervalSinceNow: -60*60*24*3)
        let twoDaysAgo = Date(timeIntervalSinceNow: -60*60*24*2)
        let yesterday = Date(timeIntervalSinceNow: -60*60*24)
        
        let todayData = results.filter { $0.date > yesterday }
        let yesterdayData = results.filter { $0.date > twoDaysAgo && $0.date < yesterday }
        let threeDaysAgoData = results.filter { $0.date > threeDaysAgo && $0.date < twoDaysAgo }
        let fourDaysAgoData = results.filter { $0.date > threeDaysAgo && $0.date < twoDaysAgo }
        let fiveDaysAgoData = results.filter { $0.date > fiveDaysAgo && $0.date < fourDaysAgo }
        let sixDaysAgoData = results.filter { $0.date > sixDaysAgo && $0.date < fiveDaysAgo }
        let weekAgoData = results.filter { $0.date > weekAgo && $0.date < sixDaysAgo }
        
        let todayQuality1 = todayData.filter { $0.quality == 1 }
        let todayQuality2 = todayData.filter { $0.quality == 2 }
        let todayQuality3 = todayData.filter { $0.quality == 3 }
        let todayArray = [todayQuality1, todayQuality2, todayQuality3]
        
        let yesterdayQuality1 = yesterdayData.filter { $0.quality == 1 }
        let yesterdayQuality2 = yesterdayData.filter { $0.quality == 2 }
        let yesterdayQuality3 = yesterdayData.filter { $0.quality == 3 }
        let yesterdayArray = [yesterdayQuality1, yesterdayQuality2, yesterdayQuality3]
        //yesterday からは自分で頑張る
        
        let threeDaysQuality1 = threeDaysAgoData.filter { $0.quality == 1 }
        let threeDaysQuality2 = threeDaysAgoData.filter { $0.quality == 2 }
        let threeDaysQuality3 = threeDaysAgoData.filter { $0.quality == 3 }
        let threeDaysArray = [threeDaysQuality1, threeDaysQuality2, threeDaysQuality3]
        
        let fourDaysQuality1 = fourDaysAgoData.filter { $0.quality == 1 }
        let fourDaysQuality2 = fourDaysAgoData.filter { $0.quality == 2 }
        let fourDaysQuality3 = fourDaysAgoData.filter { $0.quality == 3 }
        let fourDaysArray = [fourDaysQuality1, fourDaysQuality2, fourDaysQuality3]
        
        let fiveDaysQuality1 = fiveDaysAgoData.filter { $0.quality == 1 }
        let fiveDaysQuality2 = fiveDaysAgoData.filter { $0.quality == 2 }
        let fiveDaysQuality3 = fiveDaysAgoData.filter { $0.quality == 3 }
        let fiveDaysArray = [fiveDaysQuality1, fiveDaysQuality2, fiveDaysQuality3]
        
        let sixDaysQuality1 = sixDaysAgoData.filter { $0.quality == 1 }
        let sixDaysQuality2 = sixDaysAgoData.filter { $0.quality == 2 }
        let sixDaysQuality3 = sixDaysAgoData.filter { $0.quality == 3 }
        let sixDaysArray = [sixDaysQuality1, sixDaysQuality2, sixDaysQuality3]
        
        let weekAgoQuality1 = weekAgoData.filter { $0.quality == 1 }
        let weekAgoQuality2 = weekAgoData.filter { $0.quality == 2 }
        let weekAgoQuality3 = weekAgoData.filter { $0.quality == 3 }
        let weekAgoArray = [weekAgoQuality1, weekAgoQuality2, weekAgoQuality3]

        let today = todayArray.map {
            $0.map {
                $0.time
            }.reduce(0) { (num1, num2) -> Double in
                num1 + num2
            }
        }
        
        let twoDays = yesterdayArray.map {
            $0.map {
                $0.time
            }.reduce(0) { (num1, num2) -> Double in
                num1 + num2
            }
        }
        
        let threeDays = threeDaysArray.map {
            $0.map {
                $0.time
            }.reduce(0) { (num1, num2) -> Double in
                num1 + num2
            }
        }
        
        let fourDays = fourDaysArray.map {
            $0.map {
                $0.time
            }.reduce(0) { (num1, num2) -> Double in
                num1 + num2
            }
        }
        
        let fiveDays = fiveDaysArray.map {
            $0.map {
                $0.time
            }.reduce(0) { (num1, num2) -> Double in
                num1 + num2
            }
        }
        
        let sixDays = sixDaysArray.map {
            $0.map {
                $0.time
            }.reduce(0) { (num1, num2) -> Double in
                num1 + num2
            }
        }
        
        let sevenDaysAgo = weekAgoArray.map {
            $0.map {
                $0.time
            }.reduce(0) { (num1, num2) -> Double in
                num1 + num2
            }
        }
        
        print([today, twoDays, threeDays, fourDays, fiveDays, sixDays, sevenDaysAgo])
        
        setupBarChart(inputData: [today, twoDays, threeDays, fourDays, fiveDays, sixDays, sevenDaysAgo])
//        array.reduce(0) {(todayQuality1 , todayQuality2 , todayQuality3)}
//        todayQuality1 + todayQuality2 + todayQuality3
//
//        let newArray = array.map { $0. timer }
//        newArray
//        array.reduce(0) { (todayQuality1, todayQuality2, todayQuality3) -> Int in
//            todayQuality1 + todayQuality2 + todayQuality3
//        }
        
        
    }
    
    func setupBarChart(inputData: [[Double]]) {
        
//        let entries = inputData.enumerated().map { BarChartDataEntry(x: Double($0.offset), yValues: $0.flatMap{ $0 })}
        
        //dummy data below...
//        let rawData: [Int] = [20, 50, 70, 30, 60, 90, 40]
        //たとえば一番最初は20だから全部20ずつ合計で20×３で60になる
        let entries = inputData.map { BarChartDataEntry(x: Double(inputData.index(of: $0)!), yValues: $0) }
        
        
        let dataSet = BarChartDataSet(entries: entries)
        let data = BarChartData(dataSet: dataSet)
        barChartView.data = data
        
        // X軸のラベルの位置を下に設定
        barChartView.xAxis.labelPosition = .bottom
        // X軸のラベルの色を設定
        barChartView.xAxis.labelTextColor = UIColor(named: "n")!
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
        barChartView.leftAxis.labelTextColor = UIColor(named: "n")!
        // グリッドの色を設定
        barChartView.leftAxis.gridColor = UIColor(named: "n")!
        // 軸線は非表示にする
        barChartView.leftAxis.drawAxisLineEnabled = false
        
        barChartView.legend.enabled = false
        
        dataSet.drawValuesEnabled = false
        dataSet.colors = [UIColor(named: "charts-deepblue")!,
                          UIColor(named: "charts-blue")!,   
                          UIColor(named: "charts-lightblue")!]
        
        // 平均
//        let avg = inputData.reduce(0) { return $0 + $1 } / rawData.count
//        let limitLine = ChartLimitLine(limit: Double(avg))
//        limitLine.lineColor = .systemOrange
//        limitLine.lineDashLengths = [4]
//        barChartView.leftAxis.addLimitLine(limitLine)
    }
}
