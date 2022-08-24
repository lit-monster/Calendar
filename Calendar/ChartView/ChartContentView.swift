//
//  ChartContentView.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2022/06/29.
//

import SwiftUI

struct ChartContentView: View {
    
    @State var selectedPeriod: GraphPeriod = .week
    var toyShapes: [ToyShape]
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Period", selection: $selectedPeriod) {
                    ForEach(GraphPeriod.allCases) {
                        period in
                        Text(period.rawValue).tag(period)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                ChartPeriodView().frame(maxWidth: .infinity).padding()
                BarChartView(stackedBarData: toyShapes)
            }.navigationTitle(Text("集中グラフ"))
        }
        
    }
}

struct ChartContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChartContentView(toyShapes: [
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
        ])
    }
}


enum GraphPeriod: String, CaseIterable, Identifiable {
    case week = "W"
    case month = "M"
    case threeMonthes = "3M"
    case sixMonthes = "6M"
    
    var id: String { rawValue }
}
