//
//  DateRange.swift
//  StructuralHoroscope
//
//  Created by sihtmark on 31.07.2023.
//

import Foundation

struct DateManager {
    static let instance = DateManager()
    
    var dateRange: ClosedRange<Date> {
        var dateComponents = DateComponents()
        dateComponents.year = 1850
        dateComponents.month = 1
        dateComponents.day = 1
        let calendar = Calendar(identifier: .gregorian)
        let min = calendar.date(from: dateComponents)!
        let max = Date()
        return min...max
    }
    
    var calendarDateRange: ClosedRange<Date> {
        var dateComponents = DateComponents()
        dateComponents.year = 2020
        dateComponents.month = 2
        dateComponents.day = 1
        let calendar = Calendar(identifier: .gregorian)
        let min = calendar.date(from: dateComponents)!
        let max = Calendar.current.date(byAdding: .year, value: 10, to: Date())!
        return min...max
    }
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }
}
