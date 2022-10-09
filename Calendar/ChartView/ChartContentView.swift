//
//  ChartContentView.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2022/06/29.
//

import SwiftUI
import MapKit

struct ChartContentView: View {
    
    @State var selectedPeriod: GraphPeriod = .week
    var toyShapes: [ToyShape]
    var totalStudyTime: TimeInterval
    @State var totalTimeString = ""
    var studyConditionForLast2Weeks = StudyRecordManager.shared.getLast2Weeks()
    var studyConditionForWeek = StudyRecordManager.shared.getWeekData()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 35.6208255,
                                       longitude: 139.7393898),
        latitudinalMeters: 750,
        longitudinalMeters: 750
    )
    var places: [IdentifiablePlace] = StudyRecordManager.shared.getLast2WeeksCondition().places
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Group {
                        ChartPeriodView(totalTimeString: totalTimeString)
                            .frame(maxWidth: .infinity)
                        ZStack{
                            Rectangle()
                                .fill(.ultraThinMaterial.opacity(0.8).shadow(.inner(color: Color(uiColor: .systemBackground), radius: 16)))
                                .cornerRadius(16)
                                .shadow(color: .black.opacity(0.2),radius: 16)
                            BarChartView(stackedBarData: toyShapes)
                                .frame(height: 300)
                                .padding()
                                .background(.ultraThinMaterial)
                                .cornerRadius(16)
                            Spacer(minLength: 48)
                        }
                        VStack {
                            Text("ログインボーナス")
                                .font(.system(.title, design: .default))
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                            ZStack{
                                Rectangle()
                                    .fill(.ultraThinMaterial.opacity(0.8).shadow(.inner(color: Color(uiColor: .systemBackground), radius: 16)))
                                    .cornerRadius(16)
                                    .shadow(color: .black.opacity(0.2),radius: 16)
                                CalendarView(configuretion: CalendarView.Configuration(calendar: Calendar(identifier: .gregorian),
                                                                                       locale: Locale(identifier: "ja_JP"),
                                                                                       fontDesign: .rounded))
                            }
                        }
                        
                        VStack {
                            Text("マップ")
                                .font(.system(.title, design: .default))
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                            ZStack{
                                Map(coordinateRegion: $region, annotationItems: places) { place -> MapMarker in
                                    switch place.quality {
                                    case 0:
                                        return MapMarker(coordinate: place.location, tint: Color("charts-lightblue"))
                                    case 1:
                                        return MapMarker(coordinate: place.location, tint: Color("charts-blue"))
                                    case 2:
                                        return MapMarker(coordinate: place.location, tint: Color("charts-deepblue"))
                                    default:
                                        return MapMarker(coordinate: place.location, tint: Color("charts-blue"))
                                    }

                                }
                                .frame(width: 400, height: 400)
                                .cornerRadius(20)
                                .shadow(color: .black.opacity(0.2),radius: 16)
                                Spacer(minLength: 48)
                            }
                        }
                        
                        HStack {
                            Text("ハイライト")
                                .font(.system(.title, design: .default))
                                .bold()
                            Spacer(minLength: 24)
                        }
                    }
                    
                    let yesterday = studyConditionForWeek[1].superConcentratingTime
                    let today = studyConditionForWeek[0].superConcentratingTime
                    Group{
                        HighlightCell(title: "超集中",
                                      subTitle: "今日は昨日の超集中の\(yesterday > 0 ? String(Int(today / yesterday * 100)) : "-")%勉強しました。",
                                      breakdowns: [
                                        Breakdown(title: "今日", maxValue: studyConditionForWeek[0].superConcentratingTime, currentValue: today),
                                        Breakdown(title: "昨日", maxValue: studyConditionForWeek[1].superConcentratingTime, currentValue: yesterday),
                                        Breakdown(title: "一昨日", maxValue: studyConditionForWeek[2].superConcentratingTime, currentValue: studyConditionForWeek[2].superConcentratingTime),
                                      ])
                        Spacer(minLength: 24)
                        HighlightCell(title: "集中",
                                      subTitle: "今日の勉強時間は昨日の集中の\(yesterday > 0 ? String(Int(today / yesterday * 100)) : "-")%です。",
                                      breakdowns: [
                                        Breakdown(title: "今日", maxValue: studyConditionForWeek[0].concentratingTime, currentValue: today),
                                        Breakdown(title: "昨日", maxValue: studyConditionForWeek[1].concentratingTime, currentValue: yesterday),
                                        Breakdown(title: "一昨日", maxValue: studyConditionForWeek[2].concentratingTime, currentValue: studyConditionForWeek[2].concentratingTime),
                                      ])
                        Spacer(minLength: 24)
                        HighlightCell(title: "普通",
                                      subTitle: "今日の勉強時間は昨日の普通の\(yesterday > 0 ? String(Int(today / yesterday * 100)) : "-")%です。",
                                      breakdowns: [
                                        Breakdown(title: "今日", maxValue: studyConditionForWeek[0].normalTime, currentValue: today),
                                        Breakdown(title: "昨日", maxValue: studyConditionForWeek[1].normalTime, currentValue: yesterday),
                                        Breakdown(title: "一昨日", maxValue: studyConditionForWeek[2].normalTime, currentValue: studyConditionForWeek[2].normalTime),
                                      ])
                        Spacer(minLength: 24)
                        let thisWeek = studyConditionForWeek[0].total
                        let lastWeek = studyConditionForWeek[1].total
                        HighlightCell(title: "週の合計",
                                      subTitle: "今週の勉強時間は先週の\(lastWeek > 0 ? String(Int(thisWeek / lastWeek * 100)) : "-")%です。",
                                      breakdowns: [
                                        Breakdown(title: "今週", maxValue: lastWeek, currentValue: thisWeek)
                                      ])
                    }
                }

//                Group{
//                    Text("Topに戻る")
//                                    .font(.largeTitle)
//                                    .padding(.bottom)
//
//                                Button(action: {
//                                    if(self.flag){
//                                        self.labelText = "SwiftUI Test"
//                                        self.flag = false
//                                    }
//                                    else{
//                                        self.labelText = "tapped !"
//                                        self.flag = true
//                                    }
//                                }){
//                                    Text("Button")
//                                        .font(.largeTitle)
//                                        .foregroundColor(Color.white)
//                                }
//                                .padding(.all)
//                                .background(Color.blue)
//                }

                .padding()
                .navigationTitle(Text("分析"))
            }
            .background(Image("glass3"))
            .background(Color(uiColor: UIColor(named: "summary")!))
        }
        .onAppear {
            let interval = Int(totalStudyTime)
            let seconds = interval % 60
            let minutes = (interval / 60) % 60
            let hours = (interval / 3600)
            totalTimeString =  String(format: "%02dh %02dm %02ds", hours, minutes, seconds)
        }
    }
    
    struct ChartContentView_Previews: PreviewProvider {
        static var previews: some View {
            ChartContentView(toyShapes: [
                .init(color: "Green", type: "Cube", count: 2),
                .init(color: "Pink", type: "Cube", count: 1),
                .init(color: "Yellow", type: "Cube", count: 1),
                .init(color: "Green", type: "Sphere", count: 5),
                .init(color: "Pink", type: "Sphere", count: 2),
                .init(color: "Yellow", type: "Sphere", count: 1),
                .init(color: "Green", type: "Pyramid", count: 5),
                .init(color: "Pink", type: "Pyramid", count: 6),
                .init(color: "Yellow", type: "Pyramid", count: 2),
                .init(color: "Green", type: "aaa", count: 2),
                .init(color: "Pink", type: "aaa", count: 3),
                .init(color: "Yellow", type: "aaa", count: 4),
                .init(color: "Green", type: "bbb", count: 6),
                .init(color: "Pink", type: "bbb", count: 4),
                .init(color: "Yellow", type: "bbb", count: 7),
                .init(color: "Green", type: "ccc", count:5),
                .init(color: "Pink", type: "ccc", count: 1),
                .init(color: "Yellow", type: "ccc", count: 4),
                .init(color: "Green", type: "ddd", count: 4),
                .init(color: "Pink", type: "ddd", count: 5),
                .init(color: "Yellow", type: "ddd", count: 2)
            ], totalStudyTime: 1234)
        }
    }
    
    
    enum GraphPeriod: String, CaseIterable, Identifiable {
        case week = "W"
        case month = "M"
        case threeMonthes = "3M"
        case sixMonthes = "6M"
        var id: String { rawValue }
    }
}
