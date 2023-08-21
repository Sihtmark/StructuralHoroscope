//
//  ContactStruct.swift
//  StructuralHoroscope
//
//  Created by sihtmark on 31.07.2023.
//

import Foundation

struct ContactStruct: Identifiable, Codable, Equatable, Hashable {
    var id = UUID()
    var name: String
    var birthday: Date
    var sex: Sex
    var annualSignStruct: AnnualSignStruct
    var month: MonthEnum
    var isFavorite: Bool
    var contact: EventStruct?
    
    mutating func updateInfo(name: String, sex: Sex, birthday: Date, sign: AnnualSignStruct, month: MonthEnum, isFavorite: Bool, distance: Int, component: Components, reminder: Bool) {
        self.name = name
        self.sex = sex
        self.birthday = birthday
        self.annualSignStruct = sign
        self.month = month
        self.isFavorite = isFavorite
        self.contact?.updateInfo(distance: distance, component: component, reminder: reminder)
    }
    
    mutating func updateWithoutEvent(name: String, sex: Sex, birthday: Date, sign: AnnualSignStruct, month: MonthEnum, isFavorite: Bool) {
        self.name = name
        self.sex = sex
        self.birthday = birthday
        self.annualSignStruct = sign
        self.month = month
        self.isFavorite = isFavorite
    }
    
    mutating func changeLastContact(date: Date) {
        self.contact?.updateLastContact(lastContact: date)
    }
    
    mutating func updateAndCreateEvent(name: String, sex: Sex, birthday: Date, sign: AnnualSignStruct, month: MonthEnum, isFavorite: Bool, distance: Int, component: Components, lastContact: Date, reminder: Bool, feeling: Feelings, describe: String) {
        let newContact = EventStruct(distance: distance, component: component, lastContact: lastContact, reminder: reminder, allEvents: [MeetingStruct(date: lastContact, feeling: feeling, describe: describe)])
        
        self.name = name
        self.sex = sex
        self.birthday = birthday
        self.month = month
        self.isFavorite = isFavorite
        self.contact = newContact
    }
    
    mutating func updateInfoAndDeleteEvent(name: String, sex: Sex, birthday: Date, sign: AnnualSignStruct, month: MonthEnum, isFavorite: Bool) {
        self.name = name
        self.sex = sex
        self.birthday = birthday
        self.month = month
        self.isFavorite = isFavorite
        self.contact = nil
    }
    
    mutating func addMeeting(contact: EventStruct, date: Date, feeling: Feelings, describe: String) {
        self.contact?.addMeeting(date: date, feeling: feeling, describe: describe)
    }
}

let sampleContact = ContactStruct(
    name: "Зинаида",
    birthday: Date(),
    sex: .male,
    annualSignStruct: horseSign,
    month: MonthEnum.april,
    isFavorite: false,
    contact: EventStruct(
        distance: 3,
        component: Components.day,
        lastContact: Date(),
        reminder: false,
        allEvents: [
            MeetingStruct(date: Date(), feeling: Feelings.veryGood, describe: "посидели в Метрополь кафе на последнем этаже. Классно пообщались, обсудили все темы"),
            MeetingStruct(date: Date(), feeling: Feelings.notTooBad, describe: "поговорили по телефону, узнали что у друг друга нового, договорились в следующий раз попить кофе в Старбаксе на набережной")
        ]
    )
)
