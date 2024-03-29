//
//  ChartContentView.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2022/06/29.
//

import SwiftUI
import MapKit
import Charts

struct ChartContentView: View {

    var toyShapes: [ToyShape]
    var totalStudyTime: TimeInterval
    @State var totalTimeString = ""
    let studyConditionForLast2Weeks = StudyRecordManager.shared.getLast2Weeks()
    let studyConditionForWeek = StudyRecordManager.shared.getWeekData()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 35.6809591,
                                       longitude: 139.7673068),
        latitudinalMeters: 5000,
        longitudinalMeters: 5000
    )

    @State var places = [IdentifiablePlace]()  {
        didSet {
            if let last = places.last {
                region = MKCoordinateRegion(
                    center: last.location,
                    latitudinalMeters: 10000,
                    longitudinalMeters: 10000)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Spacer(minLength: 148)
                    ChartPeriodView(totalTimeString: totalTimeString)
                        .frame(maxWidth: .infinity)
                    ZStack{
                        Rectangle()
                            .fill(.ultraThinMaterial.opacity(0.6).shadow(.inner(color: Color(uiColor: .systemGroupedBackground), radius: 16)))
                            .cornerRadius(16)
                            .shadow(color: .black.opacity(0.2),radius: 16)
                        BarChartView(stackedBarData: toyShapes)
                            .frame(height: 250)
                            .padding()
                            .cornerRadius(16)
                    }

                    Spacer(minLength: 48)

                    //                    Group {
                    //                        Text("今週全体の集中度")
                    //                            .font(.system(.title, design: .rounded))
                    //                            .bold()
                    //                            .frame(maxWidth: .infinity, alignment: .leading)
                    //                        ZStack {
                    //                            Rectangle()
                    //                                .fill(.ultraThinMaterial.opacity(0.8).shadow(.inner(color: Color(uiColor: .systemBackground), radius: 16)))
                    //                                .cornerRadius(16)
                    //                                .shadow(color: .black.opacity(0.3),radius: 16)
                    //                           StrorageChartView()
                    //                            .frame(height: 100)
                    //                            .padding(15)
                    //                        }
                    //                    }
                    //
                    //                    Spacer(minLength: 48)

                    Group {
                        Text("勉強した場所")
                            .font(.system(.title, design: .rounded))
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        ZStack {
                            Map(coordinateRegion: $region, annotationItems: places) { place -> MapMarker in
                                switch place.quality {
                                case 1:
                                    return MapMarker(coordinate: place.location, tint: Color("charts-lightblue"))
                                case 2:
                                    return MapMarker(coordinate: place.location, tint: Color("charts-blue"))
                                case 3:
                                    return MapMarker(coordinate: place.location, tint: Color("charts-deepblue"))
                                default:
                                    return MapMarker(coordinate: place.location, tint: Color("charts-blue"))
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .aspectRatio(1, contentMode: .fill)
                            .cornerRadius(16)
                            .shadow(color: .black.opacity(0.2),radius: 16)
                        }
                    }

                    Spacer(minLength: 148)

                    //                    Group {
                    //                        Text("ハイライト")
                    //                            .font(.system(.title,design: .rounded))
                    //                            .bold()
                    //                            .frame(maxWidth: .infinity, alignment: .leading)
                    //
                    //                        let yesterday = studyConditionForWeek[1].superConcentratingTime
                    //                        let today = studyConditionForWeek[0].superConcentratingTime
                    //                        HighlightCell(title: "超集中",
                    //                                      subTitle: "今日の勉強時間は昨日の超集中の\(yesterday > 0 ? String(Int(today / yesterday * 100)) : "-")% です。",
                    //                                      breakdowns: [
                    //                                        Breakdown(title: "今日", maxValue: studyConditionForWeek[0].superConcentratingTime, currentValue: today),
                    //                                        Breakdown(title: "昨日", maxValue: studyConditionForWeek[1].superConcentratingTime, currentValue: yesterday),
                    //                                        Breakdown(title: "一昨日", maxValue: studyConditionForWeek[2].superConcentratingTime, currentValue: studyConditionForWeek[2].superConcentratingTime),
                    //                                      ])
                    //                        Spacer(minLength: 24)
                    //                        HighlightCell(title: "集中",
                    //                                      subTitle: "今日の勉強時間は昨日の集中の\(yesterday > 0 ? String(Int(today / yesterday * 100)) : "-")% です。",
                    //                                      breakdowns: [
                    //                                        Breakdown(title: "今日", maxValue: studyConditionForWeek[0].concentratingTime, currentValue: today),
                    //                                        Breakdown(title: "昨日", maxValue: studyConditionForWeek[1].concentratingTime, currentValue: yesterday),
                    //                                        Breakdown(title: "一昨日", maxValue: studyConditionForWeek[2].concentratingTime, currentValue: studyConditionForWeek[2].concentratingTime),
                    //                                      ])
                    //                        Spacer(minLength: 24)
                    //                        HighlightCell(title: "普通",
                    //                                      subTitle: "今日の勉強時間は昨日の普通の \(yesterday > 0 ? String(Int(today / yesterday * 100)) : "-")%です。",
                    //                                      breakdowns: [
                    //                                        Breakdown(title: "今日", maxValue: studyConditionForWeek[0].normalTime, currentValue: today),
                    //                                        Breakdown(title: "昨日", maxValue: studyConditionForWeek[1].normalTime, currentValue: yesterday),
                    //                                        Breakdown(title: "一昨日", maxValue: studyConditionForWeek[2].normalTime, currentValue: studyConditionForWeek[2].normalTime),
                    //                                      ])
                    //                        Spacer(minLength: 24)
                    //                        let thisWeek = studyConditionForWeek[0].total
                    //                        let lastWeek = studyConditionForWeek[1].total
                    //                        HighlightCell(title: "今週と先週の比較",
                    //                                      subTitle: "今週の勉強時間は先週の\(lastWeek > 0 ? String(Int(thisWeek / lastWeek * 100)) : "-")% です。",
                    //                                      breakdowns: [
                    //                                        Breakdown(title: "今週", maxValue: lastWeek, currentValue: thisWeek)
                    //                                      ])
                    //                    }
                }
                .padding()
                .navigationTitle(Text("分析"))
            }
            .background(Image("back"))
            .edgesIgnoringSafeArea(.all)
        }
        .onAppear {
            let interval = Int(totalStudyTime)
            let seconds = interval % 60
            let minutes = (interval / 60) % 60
            let hours = (interval / 3600)
            totalTimeString =  String(format: "%02dh %02dm %02ds", hours, minutes, seconds)
            places = StudyRecordManager.shared.getLast2WeeksCondition().places
        }
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
