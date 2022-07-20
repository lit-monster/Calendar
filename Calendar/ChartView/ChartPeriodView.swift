//
//  ChartPeriodView.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2022/06/29.
//

import SwiftUI

struct ChartPeriodView: View {
    @State var totalTimeString = "5h30m"
    @State var periodString = "Dec 5-11, 2021"
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(totalTimeString)
                    .font(.title)
                    .bold()
                Text("TOTAL")
                    .font(.headline)
                    .foregroundColor(Color(uiColor: UIColor.systemGray2))
                Text(periodString)
                    .font(.headline)
                    .foregroundColor(Color(uiColor: UIColor.systemGray2))
            }
            Spacer()
        }
        
    }
}

struct ChartPeriodView_Previews: PreviewProvider {
    static var previews: some View {
        ChartPeriodView()
    }
}
