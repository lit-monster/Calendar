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
        let startDate = calendar.date(byAdding: .day, value: -10, to: calendar.startOfDay(for: date))
        
        let heartRateUnit:HKUnit = HKUnit(from: "count/min")
        
        let query = HKSampleQuery(sampleType: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!, predicate: HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: []), limit: HKObjectQueryNoLimit, sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: true)]){ (query, results, error) in
            
            print(results![0])
            
            for result in results ?? [] {
                guard let currData = result as? HKQuantitySample else { return }
                print("心拍数: \(currData.quantity.doubleValue(for: heartRateUnit))")
                let heartRate = currData.quantity.doubleValue(for: heartRateUnit)
                self.heartRateArray.append(heartRate)
            }
            
        }
        myHealthStore.execute(query)
        print("心拍数の配列")
        print(heartRateArray)
    }
   
}
