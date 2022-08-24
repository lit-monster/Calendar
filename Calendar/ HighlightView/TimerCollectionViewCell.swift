//
//  TimerCollectionViewCell.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2022/08/24.
//

import SwiftUI

struct TimerCollectionViewCell: View {
    @State var nowD:Date = Date()
    let setDate:Date
    
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            self.nowD = Date()
        }
    }
    var body: some View {
        Text(TimerFunc(from: setDate))
            .font(.largeTitle)
            .onAppear(perform: {
                _ = self.timer
            })
    }
    func TimerFunc(from date:Date)->String{
        let cal = Calendar(identifier: .japanese)
        
        let timeVal = cal.dateComponents([.day,.hour,.minute,.second], from: nowD,to: setDate)
        
        return String(format: "%02dd:%02dh:%02dm:%02ds",
                      timeVal.day ?? 00,
                      timeVal.hour ?? 00,
                      timeVal.minute ?? 00,
                      timeVal.second ?? 00)
        
    }
    
}

struct TimerCollectionViewCell_Previews: PreviewProvider {
    static var previews: some View {
        TimerCollectionViewCell()
    }
}
