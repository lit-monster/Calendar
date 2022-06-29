import SwiftUI
import RealmSwift
import Charts
import Foundation

struct BarChart: Identifiable {
    var name: String
    var color: String
    var type: String
    var count: Double
    var id: String { name }
    var barmark: Character
}
struct ShapeType: Identifiable {
    let type: String
    let count: Int
    let id = UUID()
}
struct ToyShape: Identifiable {
    var color: String
    let type: String
    let count: Int
    let id = UUID()
}

let realm = try! Realm()

struct BarChartView: View {
    var data: [ShapeType] = [
    ]
    
    var stackedBarData: [ToyShape] = [
        .init(color: "Green", type: "Cube", count: 2),
        .init(color: "Pink", type: "Cube", count: 1),
        .init(color: "Yellow", type: "Cube", count: 1),
        .init(color: "Green", type: "Sphere", count: 5),
        .init(color: "Pink", type: "Sphere", count: 2),
        .init(color: "Yellow", type: "Sphere", count: 1),
        .init(color: "Green", type: "Pyramid", count: 5),
        .init(color: "Pink", type: "Pyramid", count: 6),
        .init(color: "Yellow", type: "Pyramid", count: 2),
        .init(color: "Green", type: "aaa", count: 2),
        .init(color: "Pink", type: "aaa", count: 3),
        .init(color: "Yellow", type: "aaa", count: 4),
        .init(color: "Green", type: "bbb", count: 6),
        .init(color: "Pink", type: "bbb", count: 4),
        .init(color: "Yellow", type: "bbb", count: 7),
        .init(color: "Green", type: "ccc", count:5),
        .init(color: "Pink", type: "ccc", count: 1),
        .init(color: "Yellow", type: "ccc", count: 4),
        .init(color: "Green", type: "ddd", count: 4),
        .init(color: "Pink", type: "ddd", count: 5),
        .init(color: "Yellow", type: "ddd", count: 2)
    ]
    
    var body: some View {
        Chart {
            ForEach(data) { shape in
                BarMark(
                    x: .value("Shape Type", shape.type),
                    y: .value("Total Count", shape.count)
                )
                //                .foregroundStyle(by: .value("Shape Color", shape.count))
            }
            ForEach(stackedBarData) { shape in
                BarMark(
                    x: .value("Shape Type", shape.type),
                    y: .value("Total Count", shape.count)
                )
                .foregroundStyle(by: .value("Shape Color", shape.color))
            }
        }
        .chartForegroundStyleScale([
            "Green": .green,  "Pink": .pink, "Yellow": .yellow
        ])
    }
}


struct BarChart_Previews: PreviewProvider {
    static var previews: some View {
        BarChartView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
    }
}

final class BarChartViewHostingController: UIHostingController<BarChartView> {
    override init(rootView: BarChartView) {
        super.init(rootView: rootView)
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
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
    
    //        setupBarChart(inputData: [today, twoDays, threeDays, fourDays, fiveDays, sixDays, sevenDaysAgo])
    //        array.reduce(0) {(todayQuality1 , todayQuality2 , todayQuality3)}
    //        todayQuality1 + todayQuality2 + todayQuality3
    //
    //        let newArray = array.map { $0. timer }
    //        newArray
    //        array.reduce(0) { (todayQuality1, todayQuality2, todayQuality3) -> Int in
    //            todayQuality1 + todayQuality2 + todayQuality3
}

//barChartView.legend.enabled = false
//
//dataSet.drawValuesEnabled = false
//dataSet.colors = [UIColor(named: "charts-deepblue")!,
//                  UIColor(named: "charts-blue")!,
//                  UIColor(named: "charts-lightblue")!]
