//
//  HighlightCell.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2022/07/29.
//

import SwiftUI
struct HighlightCell: View {
    private var current = 67.0
    private var minValue = 0.0
    private var maxValue = 100.0
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.white)
                .blur(radius: 64.0)
                .cornerRadius(16)
            Rectangle()
                .fill(Color("white30").shadow(.inner(color: Color("white60"), radius: 4)))
            //
            //                .frame(width:340, height:200)
                .cornerRadius(16)
            VStack(alignment: .leading) {
                Text("超集中")
                    .font(.largeTitle)
                    .foregroundColor(.cyan)
                    .bold()
                Text("今日は昨日よりも時間が少なかったです。")
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
                        
                        Text("今日")
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
                        
                        Text("昨日")
                    }
                }
            }
            .padding()
        }
    }
}

struct HighlightCell_Previews: PreviewProvider {
    static var previews: some View {
        HighlightCell()
    }
}


//
//struct Blur: UIViewRepresentable {
//    var style: UIBlurEffect.Style = .systemMaterial
//    func makeUIView(context: Context) -> UIVisualEffectView {
//        return UIVisualEffectView(effect: UIBlurEffect(style: style))
//    }
//    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
//        uiView.effect = UIBlurEffect(style: style)
//    }
//}

