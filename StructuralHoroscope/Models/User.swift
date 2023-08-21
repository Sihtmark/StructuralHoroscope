//
//  UserStruct.swift
//  StructuralHoroscope
//
//  Created by sihtmark on 31.07.2023.
//

import Foundation

struct UserStruct: Identifiable, Codable, Equatable, Hashable {
    var id = UUID()
    var birthday: Date
    var sex: Sex
    var annualSignStruct: AnnualSignStruct
    var month: MonthEnum

    mutating func updateInfo(sex: Sex, birthday: Date, sign: AnnualSignStruct, month: MonthEnum) {
        self.sex = sex
        self.birthday = birthday
        self.annualSignStruct = sign
        self.month = month
    }
}
