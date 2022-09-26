////
////  RuleMark.swift
////  Calendar
////
////  Created by 鈴木　葵葉 on 2022/09/25.
////
//
//import SwiftUI
//import Charts
//
//struct RuleMark: View {
//    
//    struct Pollen {
//        var source: String
//        var startDate: Date
//        var endDate: Date
//        
//        init(startMonth: Int, numMonths: Int, source: String) {
//            self.source = source
//            let calendar = Calendar.autoupdatingCurrent
//            self.startDate = calendar.date(from: DateComponents(year: 2020, month: startMonth, day: 1))!
//            self.endDate = calendar.date(byAdding: .month, value: numMonths, to: startDate)!
//        }
//    }
//    
//    
//    
//    var body: some View {
////        Chart() {
////            RuleMark(
////                xStart: .value("Start Date", $0.startDate),
////                xEnd: .value("End Date", $0.endDate),
////                y: .value("Pollen Source", $0.source)
////            )
////        }
//    }
//}
//
//struct RuleMark_Previews: PreviewProvider {
//    static var previews: some View {
//        RuleMark()
//        
//    }
//}
