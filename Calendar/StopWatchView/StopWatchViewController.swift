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

    override func viewDidLoad() {
        super.viewDidLoad()
        UIDevice.current.isProximityMonitoringEnabled = true

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(proximityMonitorStateDidChange),
            name: UIDevice.proximityStateDidChangeNotification,
            object: nil
        )

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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIDevice.current.isProximityMonitoringEnabled = true
        inturrptedView.isHidden = false
        count = 0
    }

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

    @objc func proximityMonitorStateDidChange() {
        if inturrptedView.isHidden == false {
            inturrptedView.isHidden = true
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

            let heart = heartRateArray
            let sum = self.heartRateArray.reduce(0) {(num1: Double, num2: Double) -> Double in
                return num1 + num2
            }
            print(sum/Double(heart.count))
            let aveHeartRate = sum/Double(heart.count)

            if ( aveHeartRate > sum/Double(heart.count) + 1 ) {
                print("High")
                focusRate = 3
                self.result = "High"
            } else if ( sum/Double(heart.count) + 1 > aveHeartRate &&  aveHeartRate > sum/Double(heart.count) - 1 ) {
                print("Normal")
                focusRate = 2
                self.result = "Normal"
            } else if ( sum/Double(heart.count) - 1 > aveHeartRate) {
                print("Low")
                focusRate = 1
                self.result = "Low"
            } else {
                print("error")
            }
        }
        myHealthStore.execute(query)
    }
}
