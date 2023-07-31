//
//  FilterMainView.swift
//  StructuralHoroscope
//
//  Created by sihtmark on 31.07.2023.
//

import Foundation

enum FilterMainView: String, Codable, CaseIterable, Hashable {
    case standardOrder = "Без фильтра"
    case alphabeticalOrder = "По алфавиту"
    case dueDateOrder = "По дате общения"
    case favoritesOrder = "Избранные"
    case withoutTracker = "Без отслеживания"
}
