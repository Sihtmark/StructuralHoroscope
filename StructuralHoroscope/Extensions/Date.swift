//
//  Date.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 11.04.2023.
//

import Foundation
import SwiftUI

extension Date {
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }
    
//    var dateFormatter: DateFormatter {
//        let formatter = DateFormatter()
//        formatter.locale = Locale(identifier: "ru")
//        formatter.dateStyle = .long
//        formatter.timeStyle = .none
//        return formatter
//    }
    
//    func asShortDateString() -> String {
//        return shortFormatter.string(from: self)
//    }
    
//    func diff(numDays: Int) -> Date {
//        Calendar.current.date(byAdding: .day, value: numDays, to: self)!
//    }
    
//    var startOfDay: Date {
//        Calendar.current.startOfDay(for: self)
//    }
//    func noon(using calendar: Calendar = .current) -> Date {
//        calendar.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
//    }
    
//    func day(using calendar: Calendar = .current) -> Int {
//        calendar.component(.day, from: self)
//    }
    
    func adding(_ component: Calendar.Component, value: Int, using calendar: Calendar = .current) -> Date {
        calendar.date(byAdding: component, value: value, to: self)!
    }
    
//    func monthSymbol(using calendar: Calendar = .current) -> String {
//        calendar.monthSymbols[calendar.component(.month, from: self)-1]
//    }
    
    func addDate() -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .day, value: 12, to: self)!
    }
}
