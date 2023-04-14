//
//  Date.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 11.04.2023.
//

import Foundation

extension Date {
    
    init(birthdate: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.mm.yyyy"
        let date = formatter.date(from: birthdate) ?? Date()
        self.init(timeInterval: 0, since: date)
    }
}
