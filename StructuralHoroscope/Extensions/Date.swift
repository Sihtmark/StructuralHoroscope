//
//  Date.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 11.04.2023.
//

import Foundation

//extension Date {
//    private var shortFormatter: DateFormatter {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .short
//        return formatter
//    }
//    func asShortDateString() -> String {
//        return shortFormatter.string(from: self)
//    }
//}

extension Date {
    func diff(numDays: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: numDays, to: self)!
    }
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
}
