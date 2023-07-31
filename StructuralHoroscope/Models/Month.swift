//
//  MonthStruct.swift
//  StructuralHoroscope
//
//  Created by sihtmark on 31.07.2023.
//

import Foundation

enum MonthEnum: Codable, CaseIterable, Hashable {
    case april
    case may
    case june
    case july
    case augest
    case september
    case october
    case november
    case december
    case january
    case february
    case march
}

struct MonthStruct: Identifiable, Codable, Equatable, Hashable {
    var id = UUID()
    let sign: MonthEnum
    let days: [Int: ClosedRange<Int>]
}

let months: [MonthStruct] = [april, may, june, july, august, september, october, november, december, january, february, march]

let january = MonthStruct(
    sign: .january,
    days: [12: 22...31, 1: 1...21]
)

let february = MonthStruct(
    sign: .february,
    days: [1: 22...31, 2: 1...20]
)

let march = MonthStruct(
    sign: .march,
    days: [2: 21...29, 3: 1...22]
)

let april = MonthStruct(
    sign: .april,
    days: [3: 23...31, 4: 1...21]
)

let may = MonthStruct(
    sign: .may,
    days: [4: 22...30, 5: 1...22]
)

let june = MonthStruct(
    sign: .june,
    days: [5: 23...31, 6: 1...21]
)

let july = MonthStruct(
    sign: .july,
    days: [6: 22...30, 7: 1...22]
)

let august = MonthStruct(
    sign: .augest,
    days: [7: 23...31, 8: 1...21]
)

let september = MonthStruct(
    sign: .september,
    days: [8: 22...31, 9: 1...21]
)

let october = MonthStruct(
    sign: .october,
    days: [9: 22...30, 10: 1...21]
)

let november = MonthStruct(
    sign: .november,
    days: [10: 22...31, 11: 1...21]
)

let december = MonthStruct(
    sign: .december,
    days: [11: 22...30, 12: 1...21]
)

