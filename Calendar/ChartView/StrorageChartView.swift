//
//  StrorageChartView.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2022/10/10.
//

import SwiftUI
import Charts

struct StrorageChartView: View {
    @State var dataUsage = DataUsage(studyCondition: StudyRecordManager.shared.getLatestWeekData())
    var body: some View {
        Chart(dataUsage.categories) { category in
            BarMark(x: .value("size", category.size))
                .foregroundStyle(by: .value("size", category.name))
        }
        .chartForegroundStyleScale([
            "超集中": Color(UIColor(named: ConcentrationType.superConcentrating.rawValue)!),
            "集中": Color(UIColor(named: ConcentrationType.concentrating.rawValue)!),
            "普通": Color(UIColor(named: ConcentrationType.normal.rawValue)!)
        ])
        .frame(height: 80)
        .padding(30)
        .chartPlotStyle{ content in
            content.cornerRadius(3)
        }
    }
}


struct DataUsageCategory: Identifiable {
    var id: String { name }

    let name: String
    let size: Double
}

class DataUsage {
    let categories: [DataUsageCategory]
    let studyCondition: StudyCondition

    init(studyCondition: StudyCondition) {
        self.studyCondition = studyCondition
        var todayTotal: Double {
            studyCondition.normalTime + studyCondition.concentratingTime + studyCondition.superConcentratingTime
        }

        categories = [
            .init(name: "超集中", size: studyCondition.superConcentratingTime),
            .init(name: "集中", size: studyCondition.concentratingTime),
            .init(name: "普通", size: studyCondition.normalTime)
        ]
    }
}

struct StrorageChartView_Previews: PreviewProvider {
    static var previews: some View {
        StrorageChartView()
    }
}
