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
    @State var stackedBarData: [ToyShape] = []
    
    var body: some View {
        Chart {
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
        .onAppear {
            stackedBarData = StudyRecordManager.shared.getWeekData()
        }
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


//barChartView.legend.enabled = false
//
//dataSet.drawValuesEnabled = false
//dataSet.colors = [UIColor(named: "charts-deepblue")!,
//                  UIColor(named: "charts-blue")!,
//                  UIColor(named: "charts-lightblue")!]
