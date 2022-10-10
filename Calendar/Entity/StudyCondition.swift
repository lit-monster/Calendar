//
//  DayStudy.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2021/07/28.
//

import CoreLocation
import Foundation

struct StudyCondition {
    let date: Date
    let normalTime: Double
    let concentratingTime: Double
    let superConcentratingTime: Double
    let places: [IdentifiablePlace]
    var total: Double {
        normalTime + concentratingTime + superConcentratingTime
    }
    
    private func getDateString() -> String {
        let dayDelta = Calendar.current.dateComponents([.day], from: date, to: Date()).day ?? 0
        switch dayDelta {
        case 0:
            return "Today"
        case 1:
            return "Yesterday"
        default:
            return "\(dayDelta) days ago"
        }
    }
    
    func getToyShape() -> [ToyShape] {
        let dateString = getDateString()
        return [ToyShape(color: "普通", type: dateString, count: Int(normalTime)),
         ToyShape(color: "集中", type: dateString, count: Int(concentratingTime)),
         ToyShape(color: "超集中", type: dateString, count: Int(superConcentratingTime))]
    }
}
