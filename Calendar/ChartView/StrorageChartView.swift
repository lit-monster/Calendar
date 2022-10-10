//
//  StrorageChartView.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2022/10/10.
//

import SwiftUI
import Charts

struct DataUsageCategory: Identifiable {
    var id: String { name }

    let name: String
    let size: Double
}

struct DataUsage {
    let categories: [DataUsageCategory]
}

let dataUsage = DataUsage(
    categories: [
        .init(name: "App", size:60),
        .init(name: "写真", size:30),
        .init(name: "iOS", size:10)
    ]
)

struct StrorageChartView: View {
    var body: some View {
        Chart(dataUsage.categories) { category in
            BarMark(x: .value("size", category.size))
                .foregroundStyle(by: .value("size", category.size))
        }
        .frame(height: 100)
        .padding([.all],30)
    }
}

struct StrorageChartView_Previews: PreviewProvider {
    static var previews: some View {
        StrorageChartView()
    }
}
