import Foundation

extension Date {
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }
    
    func adding(_ component: Calendar.Component, value: Int, using calendar: Calendar = .current) -> Date {
        calendar.date(byAdding: component, value: value, to: self)!
    }
    
    func addDate() -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .day, value: 12, to: self)!
    }
}
