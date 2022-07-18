//
//  ChartContentView.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2022/06/29.
//

import SwiftUI

struct ChartContentView: View {
    
    @State var selectedPeriod: GraphPeriod = .week
    
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
//                BarChartView()
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }.navigationTitle(Text("集中グラフ"))
        }
        
    }
}

struct ChartContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChartContentView()
    }
}


enum GraphPeriod: String, CaseIterable, Identifiable {
    case week = "W"
    case month = "M"
    case threeMonthes = "3M"
    case sixMonthes = "6M"
    
    var id: String { rawValue }
}
