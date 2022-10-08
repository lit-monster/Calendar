//
//  calendar.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2022/10/08.
//

import UIKit
import SwiftUI

struct CalendarView: UIViewRepresentable{

    let configuretion: Configuration

    func makeUIView(context: UIViewRepresentableContext<CalendarView>) -> UICalendarView {
        let calendarView = UICalendarView(frame:  .zero)
        calendarView.delegate = context.coordinator
        calendarView.selectionBehavior = UICalendarSelectionSingleDate(delegate: context.coordinator)
        return calendarView
    }

    func makeCoordinator() -> CalendarView.Coordinator {
        return Coordinator(configuretion: configuretion)
    }

    func updateUIView(_ calendarView: UICalendarView, context: UIViewRepresentableContext<CalendarView>) {
        calendarView.calendar = self.configuretion.calendar
        calendarView.locale = self.configuretion.locale
        calendarView.fontDesign = self.configuretion.fontDesign
        calendarView.selectionBehavior = self.configuretion.selectionBehavior
    }

    class Coordinator: NSObject, UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
        let configuration: Configuration

        init(configuretion: Configuration){
            self.configuration = configuretion
        }

        func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
            guard let date = dateComponents.date else {
                return .image(UIImage(systemName: "chevron.left.forwardslash.chevron.right"), color: .secondarySystemBackground, size: .large)
            }
            let studyTimeRange = StudyRecordManager.shared.getStudyTimeRange(of: date)
            return .image(UIImage.init(systemName: "seal.fill"), color: studyTimeRange.color, size: .large)
        }

        func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateCompontents: DateComponents?) {
            if let month = dateCompontents?.month, let day = dateCompontents?.day{
                print("\(month)月\(day)日")
            }
        }
    }

    struct Configuration {
        var calendar: Calendar
        var locale: Locale
        var fontDesign: UIFontDescriptor.SystemDesign
        var selectionBehavior: UICalendarSelection?
    }
}
