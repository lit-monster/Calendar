
import Foundation

extension Date {
    func getTimeZero() -> Date {
        Calendar.current.startOfDay(for: self)
    }
}
