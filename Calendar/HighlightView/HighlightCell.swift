//
//  HighlightCell.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2022/07/29.
//

import SwiftUI

struct Breakdown: Identifiable {
    let title: String
    let maxValue: Double
    let currentValue: Double
    let id = UUID()
}

struct HighlightCell: View {
    
    //MARK: - Input Parameter
    var title: String
    var subTitle: String
    var breakdowns: [Breakdown]
    
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
                    ForEach(breakdowns) { breakdown in
                        VStack{
                            Gauge(value: breakdown.currentValue, in: 0.0...breakdown.currentValue) {
                                Text("Score")
                            } currentValueLabel: {
                                Text("\(Int(breakdown.currentValue))")
                                    .font(.headline)
                                    .foregroundColor(.cyan)
                            } minimumValueLabel: {
                                Text("\(0)")
                                    .foregroundColor(.blue)
                            } maximumValueLabel: {
                                Text("\(breakdown.maxValue)")
                                    .foregroundColor(.blue)
                            }
                            .gaugeStyle(.accessoryCircularCapacity)
                            .tint(Gradient(colors: [.cyan]))
                            
                            Text(breakdown.title)
                        }
                        Spacer()
                    }
                    //                    VStack{
                    //                        Gauge(value: current, in: minValue...maxValue) {
                    //                            Text("Score")
                    //                        } currentValueLabel: {
                    //                            Text("\(Int(current))")
                    //                                .font(.headline)
                    //                                .foregroundColor(.cyan)
                    //                        } minimumValueLabel: {
                    //                            Text("\(Int(minValue))")
                    //                                .foregroundColor(.blue)
                    //                        } maximumValueLabel: {
                    //                            Text("\(Int(maxValue))")
                    //                                .foregroundColor(.blue)
                    //                        }
                    //                        .gaugeStyle(.accessoryCircularCapacity)
                    //                        .tint(Gradient(colors: [.cyan]))
                    //
                    //                        Text(leftGaugeText)
                    //                    }
                    //
                    //
                    //                    Spacer()
                    //                    VStack {
                    //                        Gauge(value: current, in: minValue...maxValue) {
                    //                            Text("Score")
                    //                        } currentValueLabel: {
                    //                            Text("\(Int(current))")
                    //                                .font(.headline)
                    //                                .foregroundColor(.cyan)
                    //                        } minimumValueLabel: {
                    //                            Text("\(Int(minValue))")
                    //                                .foregroundColor(.blue)
                    //                        } maximumValueLabel: {
                    //                            Text("\(Int(maxValue))")
                    //                                .foregroundColor(.blue)
                    //                        }
                    //                        .gaugeStyle(.accessoryCircularCapacity)
                    //                        .tint(Gradient(colors: [.cyan]))
                    //
                    //                        Text(rightGaugeText)
                    //                    }
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
                      breakdowns: [
                        Breakdown(title: "Hello", maxValue: 100, currentValue: 30)
                      ])
    }
}
