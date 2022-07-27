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
            "普通": Color(UIColor(named: "charts-lightblue")!),
            "集中": Color(UIColor(named: "charts-blue")!),
            "超集中": Color(UIColor(named: "charts-deepblue")!)
        ])
    }
}


struct BarChart_Previews: PreviewProvider {
    static var previews: some View {
        BarChartView(stackedBarData: [
            .init(color: "普通", type: "Cube", count: 2),
            .init(color: "集中", type: "Cube", count: 1),
            .init(color: "超集中", type: "Cube", count: 1),
            .init(color: "普通", type: "Sphere", count: 5),
            .init(color: "集中", type: "Sphere", count: 2),
            .init(color: "超集中", type: "Sphere", count: 1),
            .init(color: "普通", type: "Pyramid", count: 5),
            .init(color: "集中", type: "Pyramid", count: 6),
            .init(color: "超集中", type: "Pyramid", count: 2),
            .init(color: "普通", type: "aaa", count: 2),
            .init(color: "集中", type: "aaa", count: 3),
            .init(color: "超集中", type: "aaa", count: 4),
            .init(color: "普通", type: "bbb", count: 6),
            .init(color: "集中", type: "bbb", count: 4),
            .init(color: "超集中", type: "bbb", count: 7),
            .init(color: "普通", type: "ccc", count:5),
            .init(color: "集中", type: "ccc", count: 1),
            .init(color: "超集中", type: "ccc", count: 4),
            .init(color: "普通", type: "ddd", count: 4),
            .init(color: "集中", type: "ddd", count: 5),
            .init(color: "超集中", type: "ddd", count: 2)
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
