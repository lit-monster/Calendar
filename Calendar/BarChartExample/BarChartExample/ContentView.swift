//
//  ContentView.swift
//  BarChartExample
//
//  Created by 鈴木　葵葉 on 2022/06/22.
//
import SwiftUI
import Charts

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

struct BarChartView: View {
        var data: [ShapeType] = [
//            .init(type: "Cube", count: 3),
//            .init(type: "Sphere", count: 4),
//            .init(type: "Pyramid", count: 7)
        ]
    
    var stackedBarData: [ToyShape] = [
        .init(color: "Green", type: "Cube", count: 2),
        .init(color: "Pink", type: "Cube", count: 1),
        .init(color: "Yellow", type: "Cube", count: 1),
        
        .init(color: "Green", type: "Sphere", count: 0),
        .init(color: "Pink", type: "Sphere", count: 2),
        .init(color: "Yellow", type: "Sphere", count: 1),
        
        .init(color: "Green", type: "Pyramid", count: 1),
        .init(color: "Pink", type: "Pyramid", count: 0),
        .init(color: "Yellow", type: "Pyramid", count: 2)

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
            "Green": .green, "Purple": .purple, "Pink": .pink, "Yellow": .yellow
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
