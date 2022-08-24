//
//  HealthViewController.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2022/08/13.
//

import Foundation
import UIKit
import HealthKit

class HaelthViewController: UIViewController {
    let myHealthStore = HKHealthStore()
    var typeOfHeartRate = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!
    
    //    @IBOutlet weak var HeartRateView: UIView!
    
    var heartRateArray: [Double] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    func readHeartRate() {
        //期間の設定
        let calendar = Calendar.current
        let date = Date()
        let endDate = calendar.date(byAdding: .day, value: -0, to: calendar.startOfDay(for: date))
        let startDate = calendar.date(byAdding: .day, value: -3, to: calendar.startOfDay(for: date))
        
        let heartRateUnit:HKUnit = HKUnit(from: "count/min")
        
        let query = HKSampleQuery(sampleType: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!, predicate: HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: []), limit: HKObjectQueryNoLimit, sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: true)]){ [self] (query, results, error) in
            
            print(results![0])
            
            for result in results ?? [] {
                guard let currData = result as? HKQuantitySample else { return }
                //                print("心拍数: \(currData.quantity.doubleValue(for: heartRateUnit))")
                let heartRate = currData.quantity.doubleValue(for: heartRateUnit)
                self.heartRateArray.append(heartRate)
            }
            print(self.heartRateArray)
            let heart = heartRateArray
            
            let sum = self.heartRateArray.reduce(0) {(num1: Double, num2: Double) -> Double in
                return num1 + num2
            }
            print(sum/Double(heart.count))
            
            //numにリアルタイムか直近の心拍数を入れたい
            let num = sum/Double(heart.count)
             
            if ( num > sum/Double(heart.count) + 1 ) {
                print("超集中")
            } else if ( sum/Double(heart.count) + 1 > num &&  num > sum/Double(heart.count) - 1 ) {
                print("集中")
            } else if ( sum/Double(heart.count) - 1 > num) {
                print("普通")
            } else {
                print("error")
            }
        }
        myHealthStore.execute(query)
    }
}
