//
//  CircularGauge.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2022/08/26.
//

import SwiftUI

struct CircularGauge: View {

    var remainingRate: Double
    var remainingTimeString: String
    var gaugeText: String
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color.cyan.opacity(0.3),
                    lineWidth: 30
                )
                .shadow(color: .blue.opacity(0.6),radius: 16)
            Circle()
                .trim(from: 0, to: remainingRate)
                .stroke(
                    Color.cyan,
                    style: StrokeStyle(
                        lineWidth: 30,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: remainingRate)
            VStack {
                Text(gaugeText)
                    .font(.headline)
                Text(remainingTimeString)
                    .font(.system(size: 64, weight: .bold, design: .rounded))
                    .bold()
                    .minimumScaleFactor(0.5)
            }
        }.background(.clear)
    }
}

struct CircularGauge_Previews: PreviewProvider {
    static var previews: some View {
        CircularGauge(remainingRate: 0.4, remainingTimeString: "01:40", gaugeText: "目標時間")
    }
}
