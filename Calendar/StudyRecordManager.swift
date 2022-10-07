//
//  StudyRecordManager.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2022/07/06.
//
import RealmSwift
import UIKit

final class StudyRecordManager {
    static let shared = StudyRecordManager()
    private init() {}

    let realm = try! Realm()

    func getWeekData() -> [StudyCondition] {
        var studyConditions = [StudyCondition]()
        let today = Date().getTimeZero()
        var dateLast = Date()
        for dayAgo in 0 ..< 7 {
            let dayBegnning = Calendar.current.date(byAdding: .day, value: -dayAgo, to: today)!
            studyConditions.append(getByTimeRange(from: dayBegnning, to: dateLast))
            dateLast = dayBegnning
        }
        return studyConditions
    }

    func getLatestWeekTotalStudyTime() -> TimeInterval {
        let weekConditions = getWeekData()

        let totalTimes = weekConditions.map { $0.total }
        let totalTime = totalTimes.reduce(0, +)
        return totalTime
    }

    func getStudyTimeRange(of date: Date) -> StudyTimeRange {
        let result = getByTimeRange(from: date.getTimeZero(), to: date.addingTimeInterval(86400))
        if result.total > 300 {
            return .fiveHoursOrLess
        } else if result.total > 180 {
            return .threeHoursOrLess
        } else if result.total > 60 {
            return .oneHoursOrLess
        } else {
            return .zero
        }

    }

    enum StudyTimeRange {
        case zero
        case oneHoursOrLess
        case threeHoursOrLess
        case fiveHoursOrLess
        var color: UIColor{
            switch self{
            case .zero:
                return .systemGray2
            case .oneHoursOrLess:
                return  UIColor(named: "charts-lightblue")!
            case .threeHoursOrLess:
                return  UIColor(named: "charts-blue")!
            case .fiveHoursOrLess:
                return  UIColor(named: "charts-deepblue")!
            }
        }
    }

    func getLast2Weeks() -> [StudyCondition] {
        let thisWeekBegin = Calendar.current.date(bySetting: .weekday, value: 1, of: Date().getTimeZero())!
        let lastWeekBegin = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: thisWeekBegin)!
        return [
            getByTimeRange(from: thisWeekBegin, to: Date()),
            getByTimeRange(from: lastWeekBegin, to: thisWeekBegin)
        ]
    }
    private func getByTimeRange(from: Date, to: Date) -> StudyCondition {
        let results = realm.objects(StudyRecord.self).filter { from <= $0.date && $0.date < to }
        return StudyCondition(date: from,
                                normalTime: results.filter { $0.quality == 1 }.map { $0.time }.reduce(0, +),
                                concentratingTime: results.filter { $0.quality == 2 }.map { $0.time }.reduce(0, +),
                                superConcentratingTime: results.filter { $0.quality == 3 }.map { $0.time }.reduce(0, +))
    }
    func saveRecord(quality: Int, count: Int) {
        let studyRecord = StudyRecord(date: Date(), time:  TimeInterval(count), quality: quality)
        try! realm.write {
            realm.add(studyRecord)
        }
    }
}
