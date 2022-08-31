//
//  ChartPeriodView.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2022/06/29.
//

import SwiftUI

struct ChartPeriodView: View {
    var totalTimeString: String
    @State var periodString = "THIS WEEK"
    var body: some View {
        HStack {
            VStack(alignment: .leading) {

                Text("TOTAL")
                    .font(.headline)
                    .foregroundColor(Color(uiColor: UIColor.systemGray))
                Text(periodString)
                    .font(.headline)
                    .foregroundColor(Color(uiColor: UIColor.systemGray))
                Text(totalTimeString)
                    .font(.system(.largeTitle, design: .rounded))
                    .bold()
            }
            Spacer()
        }
    }
}

struct ChartPeriodView_Previews: PreviewProvider {
    static var previews: some View {
        ChartPeriodView(totalTimeString: "02h 12m 23s")
    }
}
