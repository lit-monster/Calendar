import SwiftUI
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
struct ShapeType {
    let type: String
    let count: Int
}
var data: [ShapeType] = [
    .init(type: "Cube", count: 5),
    .init(type: "Sphere", count: 4),
    .init(type: "Pyramid", count: 4)
]
struct BarChartView: View {
    var body: some View {
        BarChart {
            BarMark(
                x: .value("Shape Type", .type),
                y: .value("Total Count", .count)
            )
        }
    }
}
