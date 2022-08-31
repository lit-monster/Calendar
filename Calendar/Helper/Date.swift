//
//  Date.swift
//  Calendar
//
//  Created by Yuji Sasaki on 2022/08/31.
//

import Foundation

extension Date {
    func getTimeZero() -> Date {
        Calendar.current.startOfDay(for: self)
    }
}
