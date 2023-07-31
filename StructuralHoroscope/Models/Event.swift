//
//  EventStruct.swift
//  StructuralHoroscope
//
//  Created by sihtmark on 31.07.2023.
//

import Foundation

struct EventStruct: Identifiable, Codable, Equatable, Hashable {
    var id = UUID()
    var distance: Int
    var component: Components
    var lastContact: Date
    var reminder: Bool
    var allEvents: [MeetingStruct]
    
    mutating func updateInfo(distance: Int, component: Components, reminder: Bool) {
        self.distance = distance
        self.component = component
        self.reminder = reminder
    }
    
    mutating func updateLastContact(lastContact: Date) {
        self.lastContact = lastContact
    }
    
    mutating func addMeeting(date: Date, feeling: Feelings, describe: String) {
        let newMeeting = MeetingStruct(date: date, feeling: feeling, describe: describe)
        self.allEvents.append(newMeeting)
    }
    
    func getNextEventDate() -> Date {
        switch component {
        case .day:
            return Calendar.current.date(byAdding: Calendar.Component.day, value: distance, to: lastContact)!
        case .week:
            return Calendar.current.date(byAdding: Calendar.Component.day, value: (distance * 7), to: lastContact)!
        case .month:
            return Calendar.current.date(byAdding: Calendar.Component.month, value: distance, to: lastContact)!
        case .year:
            return Calendar.current.date(byAdding: Calendar.Component.year, value: distance, to: lastContact)!
        }
    }
}
