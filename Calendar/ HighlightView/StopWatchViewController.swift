//
//  StopWatch.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2021/07/14.
//

import UIKit
import RealmSwift
import HealthKit

class StopWatchViewController: UIViewController {
    var feedbackGenerator : UINotificationFeedbackGenerator? = nil

    @IBOutlet var label:UILabel!
    @IBOutlet var inturrptedView: UIView!
    
    var count: Int = 0
    
    var timer: Timer = Timer()
    
    //時間の型で保存する、秒数で保存
    var startTime = TimeInterval()
    //UIDeviceクラスを呼ぶ
    let myDevice: UIDevice = UIDevice.current
    
    var result: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 近接センサーの有効化
        UIDevice.current.isProximityMonitoringEnabled = true
        
        // 近接センサーのON-Offが切り替わる通知
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(proximityMonitorStateDidChange),
            name: UIDevice.proximityStateDidChangeNotification,
            object: nil
        )
        // インスタンスを生成し prepare() をコール
        self.feedbackGenerator = UINotificationFeedbackGenerator()
        self.feedbackGenerator?.prepare()
        
        //healthkit使用の許可
        let typeOfRead = Set([typeOfHeartRate])
        myHealthStore.requestAuthorization(toShare: [],read: typeOfRead,completion: { (success, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            print(success)
        })
        
        readHeartRate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIDevice.current.isProximityMonitoringEnabled = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UIDevice.current.isProximityMonitoringEnabled = false
    }
    
    // 近接センサーのON-Offが切り替わると実行される
    @objc func proximityMonitorStateDidChange() {
//        // 表示/非表示を切り替え
//        func changeVisible(visible: Bool) {
//            if visible {
//                label.isHidden = false
//            } else {
//                label.isHidden = true
//            }
//        }
//
        if inturrptedView.isHidden == false {
            inturrptedView.isHidden = true
        }
        let proximityState = UIDevice.current.proximityState
        print(proximityState)
        if proximityState {
            if !timer.isValid {
                self.feedbackGenerator?.notificationOccurred(.success)
                //タイマーが動作してなかったら動かす
                timer = Timer.scheduledTimer(timeInterval: 1,
                                             target: self,
                                             selector: #selector(self.up),
                                             userInfo: nil,
                                             repeats:true
                )
            }
        } else {
            timer.invalidate()
            //            hapticfeedback
            self.feedbackGenerator?.notificationOccurred(.success)
            let alert = UIAlertController(title: "記録を保存する", message: "あなたの予想集中度合いは\(self.result)です", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "キャンセル", style: .cancel) { [self] (action) in
                self.dismiss(animated: true, completion: nil)
                
                self.count = count - count
                label.text = String(count)
            }
            let save = UIAlertAction(title: "保存", style: .default) { _ in
                //保存ボタンを押された時の集中度合いの通知
                //アラート生成
                //UIAlertControllerのスタイルがalert
                let alert: UIAlertController = UIAlertController(title: "集中度合いを記録しよう", message:  "どのくらい集中した？", preferredStyle: .alert)
                // 確定ボタンの処理
                let quality3Action = UIAlertAction(title: "超集中(★★★)", style: .default) { [weak self] _ in
                    guard let self = self else { return }
                    //実際の処理
                    print("超集中")
                    //保存する記録
                    let studyRecord = StudyRecord()
                    studyRecord.date = Date()
                    studyRecord.quality = 3
                    studyRecord.time = TimeInterval(self.count)
                    let realm = try! Realm()
                    try! realm.write {
                        realm.add(studyRecord)
                    }
                    self.count = 0
                }
                // 確定ボタンの処理
                let quality2Action = UIAlertAction(title: "集中(★★)", style: .default) { [weak self] _ in
                    guard let self = self else { return }
                    //実際の処理
                    print("集中")
                    //保存する記録
                    let studyRecord = StudyRecord()
                    studyRecord.date = Date()
                    studyRecord.quality = 2
                    studyRecord.time = TimeInterval(self.count)
                    let realm = try! Realm()
                    try! realm.write {
                        realm.add(studyRecord)
                    }
                    self.count = 0
                }
                // 確定ボタンの処理
                let quality1Action = UIAlertAction(title: "普通(★)", style: .default) { [weak self] _ in
                    guard let self = self else { return }
                    //実際の処理
                    print("普通")
                    //保存する記録
                    let studyRecord = StudyRecord()
                    studyRecord.date = Date()
                    studyRecord.quality = 1
                    studyRecord.time = TimeInterval(self.count)
                    let realm = try! Realm()
                    try! realm.write {
                        realm.add(studyRecord)
                    }
                    self.count = 0
                }
                
                //UIAlertControllerに集中ボタンをActionを追加
                alert.addAction(quality3Action)
                alert.addAction(quality2Action)
                alert.addAction(quality1Action)
                
                //実際にAlertを表示する
                self.present(alert, animated: true, completion: nil)
            }
            
            let pause = UIAlertAction(title: "一時停止", style: .default) { (acrion) in
                self.dismiss(animated: true, completion: nil)
            }
            
            alert.addAction(save)
            alert.addAction(pause)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func up() {
        //countを0.01足す
        count = count + 1
        //ラベル表示
        let interval = Int(count)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        label.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    //ヘルスキット系
    let myHealthStore = HKHealthStore()
    var typeOfHeartRate = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!
    
    var heartRateArray: [Double] = []
    
    func readHeartRate() {
        //期間の設定
        let calendar = Calendar.current
        let date = Date()
        let endDate = calendar.date(byAdding: .day, value: -1, to: calendar.startOfDay(for: date))
        let startDate = calendar.date(byAdding: .day, value: -20, to: calendar.startOfDay(for: date))
        print("startDate")
        print(startDate)
        print("endDate")
        print(endDate)
        
        let heartRateUnit:HKUnit = HKUnit(from: "count/min")
        
        //resultsに指定した期間のヘルスデータが取得される
        let query = HKSampleQuery(sampleType: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!, predicate: HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: []), limit: HKObjectQueryNoLimit, sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: true)]){ [self] (query, results, error) in
            
            guard results != [] else { return }
            
            print(results?[0])
            
            for result in results ?? [] {
                guard let currData = result as? HKQuantitySample else { return }
                //                print("心拍数: \(currData.quantity.doubleValue(for: heartRateUnit))")
                let heartRate = currData.quantity.doubleValue(for: heartRateUnit)
                self.heartRateArray.append(heartRate)
            }
            print(self.heartRateArray)
            
            // aveHeartRateに平均心拍数を代入
            let heart = heartRateArray
            let sum = self.heartRateArray.reduce(0) {(num1: Double, num2: Double) -> Double in
                return num1 + num2
            }
            print(sum/Double(heart.count))
            let aveHeartRate = sum/Double(heart.count)
            
            // 平均心拍数からスコアを判定
            if ( aveHeartRate > sum/Double(heart.count) + 1 ) {
                print("超集中")
                self.result = "超集中"
            } else if ( sum/Double(heart.count) + 1 > aveHeartRate &&  aveHeartRate > sum/Double(heart.count) - 1 ) {
                print("集中")
                self.result = "集中"
            } else if ( sum/Double(heart.count) - 1 > aveHeartRate) {
                print("普通")
                self.result = "普通"
            } else {
                print("error")
            }
        }
        myHealthStore.execute(query)
    }
}
