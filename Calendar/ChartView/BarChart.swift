import SwiftUI
import Charts


struct ToyShape: Identifiable {
    var color: String
    let type: String
    let count: Int
    let id = UUID()
}

struct BarChartView: View {
    var stackedBarData: [ToyShape]
    
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
    }
}


struct BarChart_Previews: PreviewProvider {
    static var previews: some View {
        BarChartView(stackedBarData: [
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
)
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
