//
//  HighlightCell.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2022/07/29.
//

import SwiftUI

struct HighlightCell: View {

    var minValue = 0.0
    var maxValue = 100.0

    //MARK: - Input Parameter
    var title: String
    var subTitle: String
    var current: Double
    var leftGaugeText: String
    var rightGaugeText: String

    //MARK: - body
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.ultraThinMaterial.opacity(0.8).shadow(.inner(color: Color(uiColor: .systemBackground), radius: 16)))
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.2),radius: 16)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.largeTitle)
                    .foregroundColor(.cyan)
                    .bold()
                Text(subTitle)
                Divider()
                HStack {
                    VStack{
                        Gauge(value: current, in: minValue...maxValue) {
                            Text("Score")
                        } currentValueLabel: {
                            Text("\(Int(current))")
                                .font(.headline)
                                .foregroundColor(.cyan)
                        } minimumValueLabel: {
                            Text("\(Int(minValue))")
                                .foregroundColor(.blue)
                        } maximumValueLabel: {
                            Text("\(Int(maxValue))")
                                .foregroundColor(.blue)
                        }
                        .gaugeStyle(.accessoryCircularCapacity)
                        .tint(Gradient(colors: [.cyan]))
                        
                        Text(leftGaugeText)
                    }
                    
                    
                    Spacer()
                    VStack {
                        Gauge(value: current, in: minValue...maxValue) {
                            Text("Score")
                        } currentValueLabel: {
                            Text("\(Int(current))")
                                .font(.headline)
                                .foregroundColor(.cyan)
                        } minimumValueLabel: {
                            Text("\(Int(minValue))")
                                .foregroundColor(.blue)
                        } maximumValueLabel: {
                            Text("\(Int(maxValue))")
                                .foregroundColor(.blue)
                        }
                        .gaugeStyle(.accessoryCircularCapacity)
                        .tint(Gradient(colors: [.cyan]))
                        
                        Text(rightGaugeText)
                    }
                }
            }
            .padding()
        }
    }
}

struct HighlightCell_Previews: PreviewProvider {
    static var previews: some View {
        HighlightCell(title: "超集中",
                      subTitle: "今日は昨日よりも時間が少なかったです。",
                      current: 34,
                      leftGaugeText: "今日",
                      rightGaugeText: "昨日")
    }
}
