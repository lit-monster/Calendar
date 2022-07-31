//
//  HighlightCell.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2022/07/29.
//

import SwiftUI
import UIKit
struct Gauge<Label, CurrentValueLabel, BoundsLabel, MarkedValueLabels>
where Label : View, CurrentValueLabel : View, BoundsLabel : View, MarkedValueLabels : View{
//    var (minValue: String, maxValue: String, value: batteryLevel)
//    var (minValue: Int, maxValue: Int, value: batteryLevel)
//    var minValue = 0
//    var maxValue = 100
//    var value = "batteryLevel"
    
    struct HighlightCell: View {
        @State private var batteryLevel = 0.4
        @State private var current = 67.0
        @State private var minValue = 0.0
        @State private var maxValue = 100.0
        var body: some View {
            Rectangle()
                .fill(.white.shadow(.inner(radius: 16)))
                .frame(width:340, height:200)
                .cornerRadius(16)
//            Gauge(value: batteryLevel) {
//                Text("Battery Level")
//            }
            Gauge(value: current, in: minValue...maxValue, value: batteryLevel) {
//                Text("BPM")
                Text("Battery Level")
            } currentValueLabel: {
                Text("\(Int(current))")
            } minimumValueLabel: {
                Text("\(Int(minValue))")
            } maximumValueLabel: {
                Text("\(Int(maxValue))")
            }
        }
        
        struct Blur: UIViewRepresentable {
            var style: UIBlurEffect.Style = .systemMaterial
            func makeUIView(context: Context) -> UIVisualEffectView {
                return UIVisualEffectView(effect: UIBlurEffect(style: style))
            }
            func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
                uiView.effect = UIBlurEffect(style: style)
            }
        }
        
        struct HighlightCell_Previews: PreviewProvider {
            static var previews: some View {
                HighlightCell()
            }
        }
    }
}
