//
//  StopWatch.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2021/07/14.
//

import UIKit
import SwiftUI
import HealthKit

class StopWatchViewController: UIViewController {
    let feedbackGenerator = UINotificationFeedbackGenerator()
    
    @IBOutlet var circularGaugeView: UIView!
    @IBOutlet var inturrptedView: UIView!
    @IBOutlet weak var upset: UILabel!
    @IBOutlet weak var iphone: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var picker: UIDatePicker! {
        didSet {
            picker.datePickerMode = .countDownTimer
            
        }
    }
    @IBOutlet weak var pickerBlurView: UIVisualEffectView! {
        didSet {
            pickerBlurView.layer.cornerCurve = .continuous
            pickerBlurView.layer.cornerRadius = 16
            pickerBlurView.clipsToBounds = true
        }
    }
    
    var count: Int = 0
    var latestHeartRate = 0.0
    var focusRate = 0
    var timer: Timer = Timer()
    var targetTimeInterval: CFTimeInterval = 0
    var startTime = TimeInterval()
    let myDevice: UIDevice = UIDevice.current
    var result: String = ""
    var diffSum: Double = 0.0
    var stdev: Double = 0.0
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
        feedbackGenerator.prepare()
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "totimer" {
            let vc = segue.destination as! TimerViewController
            vc.count = self.count
            vc.latestHeartRate = self.latestHeartRate
            vc.focusRate = self.focusRate
        }
    }
    //アプリ起動時
    //近接センサーの有効化、inturrptedViewの表示、countを０に
    override func viewDidAppear(_ animated: Bool) {
        print(UIDevice.current.userInterfaceIdiom.rawValue)

        inturrptedView.isHidden = false
        //iPhoneの時とiPadの時で分岐させる
        if UIDevice.current.userInterfaceIdiom == .phone {
            super.viewDidAppear(animated)
            UIDevice.current.isProximityMonitoringEnabled = true
            startButton.isHidden = true
            stopButton.isHidden = true
            count = 0
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            super.viewDidAppear(animated)
            upset.isHidden = true
            iphone.isHidden = true
            startButton.isHidden = false
            stopButton.isHidden = false
            count = 0
        }
    }
    //アプリ終了時
    //近接センサーの無効化
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UIDevice.current.isProximityMonitoringEnabled = false
    }
    
    @IBAction func exitButtonPressed(){
        self.performSegue(withIdentifier: "totimer", sender: nil)
    }
    
    @IBAction func loginBonusButtonPressed() {
        let loginBonusViewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "LoginBonus")
        if let sheet = loginBonusViewController.sheetPresentationController {
            sheet.detents = [.custom { context in 0.8 * context.maximumDetentValue }]
        }
        self.present(loginBonusViewController, animated: true)
    }
    
    //近接センサー
    @objc func proximityMonitorStateDidChange() {
        //inturrptedViewが表示されているとき
        if inturrptedView.isHidden == false {
            inturrptedView.isHidden = true
            //TargetTimeIntervalに設定した目標時間を代入
            targetTimeInterval = picker.countDownDuration
        }
        
        let proximityState = UIDevice.current.proximityState
        print(proximityState)
        self.feedbackGenerator.notificationOccurred(.warning)
        if proximityState {
            if !timer.isValid {
                timer = Timer.scheduledTimer(timeInterval: 1,
                                             target: self,
                                             selector: #selector(self.up),
                                             userInfo: nil,
                                             repeats:true
                )
            }
        } else {
            timer.invalidate()
        }
    }
    
    @objc func up() {
        count = count + 1
        let interval = Int(targetTimeInterval) - Int(count)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        updateGaugePrgress(remainingTime: String(format: "%02d:%02d:%02d", hours, minutes, seconds),
                           remainingRate: (targetTimeInterval - Double(count)) / targetTimeInterval)
        if interval < 0 {
            feedbackGenerator.prepare()
        }
    }
    
    func updateGaugePrgress(remainingTime: String, remainingRate: Double) {
        for view in self.circularGaugeView.subviews {
            view.removeFromSuperview()
        }
        let vc = UIHostingController(rootView: CircularGauge(remainingRate: remainingRate, remainingTimeString: remainingTime))
        self.addChild(vc)
        self.circularGaugeView.addSubview(vc.view)
        vc.didMove(toParent: self)
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        vc.view.backgroundColor = .clear
        NSLayoutConstraint.activate([
            vc.view.leadingAnchor.constraint(equalTo: circularGaugeView.leadingAnchor),
            vc.view.trailingAnchor.constraint(equalTo: circularGaugeView.trailingAnchor),
            vc.view.bottomAnchor.constraint(equalTo: circularGaugeView.bottomAnchor),
            vc.view.topAnchor.constraint(equalTo: circularGaugeView.topAnchor)])
    }
    
    let myHealthStore = HKHealthStore()
    var typeOfHeartRate = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!
    
    var heartRateArray: [Double] = []
    
    func readHeartRate() {
        let calendar = Calendar.current
        let date = Date()
        let endDate = calendar.date(byAdding: .day, value: -0, to: calendar.startOfDay(for: date))
        let startDate = calendar.date(byAdding: .day, value: -7, to: calendar.startOfDay(for: date))
        
        let heartRateUnit:HKUnit = HKUnit(from: "count/min")
        let query = HKSampleQuery(sampleType: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!, predicate: HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: []), limit: HKObjectQueryNoLimit, sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: true)]){ [self] (query, results, error) in
            
            guard results != [] else { return }
            
            for result in results ?? [] {
                guard let currData = result as? HKQuantitySample else { return }
                let heartRate = currData.quantity.doubleValue(for: heartRateUnit)
                self.heartRateArray.append(heartRate)
            }
            
            latestHeartRate = self.heartRateArray.last ?? 0
            //心拍数の配列
            let heart = heartRateArray
            //心拍数の配列の合計
            let sum = self.heartRateArray.reduce(0) {(num1: Double, num2: Double) -> Double in
                return num1 + num2
            }
            
            print(sum/Double(heart.count))
            let aveHeartRate = sum/Double(heart.count)
            
            //標準偏差の計算
            //差の合計
            for heartRate in heartRateArray{
                diffSum += heartRate - aveHeartRate
            }
            //標準偏差
            let stdev = sqrt(round(diffSum/Double(heartRateArray.count)*1000)/1000)
            print("差の合計")
            print(diffSum)
            print("標準偏差")
            print(stdev)
            print("心拍の配列の長さ")
            print(heartRateArray.count)
            print("変動係数")
            print(stdev/aveHeartRate)
            
            if ( stdev < stdev/aveHeartRate + 2) {
                print("超集中")
                focusRate = 3
                self.result = "超集中"
            } else if ( stdev < stdev/aveHeartRate - 2) {
                print("超集中")
                focusRate = 3
                self.result = "超集中"
            } else if (stdev < stdev/aveHeartRate + 1) {
                print("集中")
                focusRate = 2
                self.result = "集中"
            } else if (stdev < stdev/aveHeartRate - 1) {
                print("集中")
                focusRate = 2
                self.result = "集中"
            } else if (stdev < stdev/aveHeartRate ) {
                print("普通")
                focusRate = 1
                self.result = "普通"
            } else {
                print("error")
            }
            
            //            if ( aveHeartRate > sum/Double(heart.count) + 1 ) {
            //                print("超集中")
            //                focusRate = 3
            //                self.result = "超集中"
            //            } else if ( sum/Double(heart.count) + 1 > aveHeartRate &&  aveHeartRate > sum/Double(heart.count) - 1 ) {
            //                print("集中")
            //                focusRate = 2
            //                self.result = "集中"
            //            } else if ( sum/Double(heart.count) - 1 > aveHeartRate) {
            //                print("普通")
            //                focusRate = 1
            //                self.result = "普通"
            //            } else {
            //                print("error")
            //            }
        }
        myHealthStore.execute(query)
    }
}
