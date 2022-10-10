//
//  LoginContentViewController.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2022/10/10.
//

import SwiftUI
import Charts

struct LoginContentViewController: View {

    var studyConditionForLast2Weeks = StudyRecordManager.shared.getLast2Weeks()
    var studyConditionForWeek = StudyRecordManager.shared.getWeekData()
    
    var body: some View {
        VStack {
            Text("ログインボーナス")
                .font(.system(.title, design: .rounded))
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            ZStack{
                Rectangle()
                    .fill(.ultraThinMaterial.opacity(0.8).shadow(.inner(color: Color(uiColor: .systemBackground), radius: 16)))
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.2),radius: 16)
                CalendarView(configuretion:
                                CalendarView.Configuration(calendar:
                                                            Calendar(identifier: .gregorian),
                                                                       locale: Locale(identifier: "ja_JP"),
                                                           fontDesign: .rounded)).padding()

            }
        }

        Group{
            VStack{
                Text("集中度の割合")
                    .font(.system(.title, design: .rounded))
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                ZStack{
                    Rectangle()
                        .fill(.ultraThinMaterial.opacity(0.8).shadow(.inner(color: Color(uiColor: .systemBackground), radius: 16)))
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.3),radius: 16)
                    Chart(dataUsage.categories) { category in
                        BarMark(x: .value("size", category.size))
                            .foregroundStyle(by: .value("size", category.size))
                    }
                    .frame(height: 100)
                    .padding([.all],30)
                }
            }
        }
        Spacer(minLength: 48)

    }
    struct DataUsageCategory: Identifiable {
        var id: String { name }

        let name: String
        let size: Double
    }

    struct DataUsage {
        let categories: [DataUsageCategory]
    }

    let dataUsage = DataUsage(
        categories: [
            .init(name: "App", size:60),
            .init(name: "写真", size:30),
            .init(name: "iOS", size:10)
        ]
    )
}

struct LoginContentViewController_Previews: PreviewProvider {
    static var previews: some View {
        LoginContentViewController()
    }
}
