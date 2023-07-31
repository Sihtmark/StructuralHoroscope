//
//  MeetingStruct.swift
//  StructuralHoroscope
//
//  Created by sihtmark on 31.07.2023.
//

import Foundation

struct MeetingStruct: Identifiable, Codable, Equatable, Hashable {
    var id = UUID()
    var date: Date
    var feeling: Feelings
    var describe: String
    
    mutating func updateMeeting(date: Date, feeling: Feelings, describe: String) {
        self.date = date
        self.feeling = feeling
        self.describe = describe
    }
}
