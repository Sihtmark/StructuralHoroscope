//
//  ViewModel.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 12.04.2023.
//

import Foundation
import EventKit
import EventKitUI

class ViewModel: ObservableObject {
    
    @Published var changedEvent: DayStruct?
    @Published var movedEvent: DayStruct?
    
    @Published var mainUser: ClientStruct = sampleClient {
        didSet {
            saveMainUser()
        }
    }
    
    @Published var customers = [ClientStruct]() {
        didSet {
            saveItems()
        }
    }
    
    let itemsKey = "items_list"
    let mainUserKey = "main_user"
    
    init() {
        fetchMainUser()
        fetchCustomers()
    }
    
    func fetchMainUser() {
        guard let mainUserData = UserDefaults.standard.data(forKey: mainUserKey), let savedMainUser = try? JSONDecoder().decode(ClientStruct.self, from: mainUserData) else {return}
        self.mainUser = savedMainUser
    }
    
    func fetchCustomers() {
        guard let data = UserDefaults.standard.data(forKey: itemsKey), let savedItems = try? JSONDecoder().decode([ClientStruct].self, from: data) else {return}
        self.customers = savedItems
    }
    
    func startingDate(day: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = 2023
        dateComponents.month = 5
        dateComponents.day = day
        let calendar = Calendar(identifier: .gregorian)
        return calendar.date(from: dateComponents)!
    }
    
    func saveMainUser() {
        if let encodedData = try? JSONEncoder().encode(mainUser) {
            UserDefaults.standard.set(encodedData, forKey: mainUserKey)
        }
    }
    
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(customers) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
    
    func createMainUser(name: String, sex: Sex, birthday: Date, sign: SignStruct, zodiacSign: ZodiacEnum) {
        let newMainUser = ClientStruct(
            name: name,
            birthday: birthday,
            sex: sex,
            annualSignStruct: sign,
            zodiacSign: sampleClient.zodiacSign
        )
        mainUser = newMainUser
    }
    
    func createNewCustomer(name: String, sex: Sex, birthday: Date, sign: SignStruct, zodiacSign: ZodiacEnum) {
        let newCustomer = ClientStruct(
            name: name,
            birthday: birthday,
            sex: sex,
            annualSignStruct: sign,
            zodiacSign: zodiacSign
        )
        customers.append(newCustomer)
    }
    
    func updateMainUser(name: String, sex: Sex, birthday: Date, sign: SignStruct, zodiacSign: ZodiacEnum) {
        if mainUser == sampleClient {
            createMainUser(name: name, sex: sex, birthday: birthday, sign: sign, zodiacSign: zodiacSign)
        } else {
            mainUser = mainUser.updateInfo(name: name, sex: sex, birthday: birthday, sign: sign, zodiacSign: zodiacSign)
        }
    }
    
    func updateCustomer(client: ClientStruct, name: String, sex: Sex, birthday: Date, sign: SignStruct, zodiacSign: ZodiacEnum) {
        if let index = customers.firstIndex(where: {$0.id == client.id}) {
            customers[index] = client.updateInfo(name: name, sex: sex, birthday: birthday, sign: sign, zodiacSign: zodiacSign)
            saveItems()
        }
        fetchCustomers()
    }
    
    func deleteItem(indexSet: IndexSet) {
        customers.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        customers.move(fromOffsets: from, toOffset: to)
    }
    
    func hostString(sign: AnnualEnum) -> String {
        var str = ""
        for i in AnnualEmojiEnum.allCases {
            if "\(i)" == "\(sign)" {
                str = "\(i.rawValue)\(sign.rawValue)"
            }
        }
        return str
    }
    
    func servantString(sign: AnnualEnum) -> String {
        var str = ""
        for i in AnnualEmojiEnum.allCases {
            if "\(i)" == "\(sign)" {
                str = "\(i.rawValue)\(sign.rawValue)"
            }
        }
        return str
    }
    
    func clones(sign: SignStruct) -> String {
        var dict = [AnnualEmojiEnum: AnnualEnum]()
        for i in sign.clones {
            for e in AnnualEmojiEnum.allCases {
                if "\(e)" == "\(i)" {
                    dict[e] = i
                }
            }
        }
        return dict.map{"\($0.key.rawValue)\($0.value.rawValue)"}.joined(separator: ", ")
    }
    
    func companions(sign: SignStruct) -> String {
        var dict = [AnnualEmojiEnum: AnnualEnum]()
        for i in sign.companions {
            for e in AnnualEmojiEnum.allCases {
                if "\(e)" == "\(i)" {
                    dict[e] = i
                }
            }
        }
        return dict.map{"\($0.key.rawValue)\($0.value.rawValue)"}.joined(separator: ", ")
    }
    
    func subordinates(sign: SignStruct) -> String {
        var dict = [AnnualEmojiEnum: AnnualEnum]()
        for i in sign.subordinates {
            for e in AnnualEmojiEnum.allCases {
                if "\(e)" == "\(i)" {
                    dict[e] = i
                }
            }
        }
        return dict.map{"\($0.key.rawValue)\($0.value.rawValue)"}.joined(separator: ", ")
    }
    
    func advisers(sign: SignStruct) -> String {
        var dict = [AnnualEmojiEnum: AnnualEnum]()
        for i in sign.advisers {
            for e in AnnualEmojiEnum.allCases {
                if "\(e)" == "\(i)" {
                    dict[e] = i
                }
            }
        }
        return dict.map{"\($0.key.rawValue)\($0.value.rawValue)"}.joined(separator: ", ")
    }
    
    func vectorMarriage(sign: SignStruct) -> String {
        var dict = [AnnualEmojiEnum: AnnualEnum]()
        for i in sign.vectorMarriage {
            for e in AnnualEmojiEnum.allCases {
                if "\(e)" == "\(i)" {
                    dict[e] = i
                }
            }
        }
        return dict.map{"\($0.key.rawValue)\($0.value.rawValue)"}.joined(separator: ", ")
    }
    
    func romanticMarriage(sign: SignStruct) -> String {
        var dict = [AnnualEmojiEnum: AnnualEnum]()
        for i in sign.romanticMarriage {
            for e in AnnualEmojiEnum.allCases {
                if "\(e)" == "\(i)" {
                    dict[e] = i
                }
            }
        }
        return dict.map{"\($0.key.rawValue)\($0.value.rawValue)"}.joined(separator: ", ")
    }
    
    func equalMarriage(sign: SignStruct) -> String {
        var dict = [AnnualEmojiEnum: AnnualEnum]()
        for i in sign.equalMarriage {
            for e in AnnualEmojiEnum.allCases {
                if "\(e)" == "\(i)" {
                    dict[e] = i
                }
            }
        }
        return dict.map{"\($0.key.rawValue)\($0.value.rawValue)"}.joined(separator: ", ")
    }
    
    func spiritualMarriage(sign: SignStruct) -> String {
        var dict = [AnnualEmojiEnum: AnnualEnum]()
        for i in sign.spiritualMarriage {
            for e in AnnualEmojiEnum.allCases {
                if "\(e)" == "\(i)" {
                    dict[e] = i
                }
            }
        }
        return dict.map{"\($0.key.rawValue)\($0.value.rawValue)"}.joined(separator: ", ")
    }
    
    func patriarchalMarriage(sign: SignStruct) -> String {
        var dict = [AnnualEmojiEnum: AnnualEnum]()
        for i in sign.patriarchalMarriage {
            for e in AnnualEmojiEnum.allCases {
                if "\(e)" == "\(i)" {
                    dict[e] = i
                }
            }
        }
        return dict.map{"\($0.key.rawValue)\($0.value.rawValue)"}.joined(separator: ", ")
    }
    
    func socialSigns(socialEnum: SocialEnum) -> [SignStruct] {
        switch socialEnum {
        case .opened:
            return [ratSign, catSign, horseSign, roosterSign]
        case .closed:
            return [tigerSign, snakeSign, monkeySign, boarSign]
        case .orthodox:
            return [bullSign, dragonSign, goatSign, dogSign]
        }
    }
    
    func ideologicalSigns(ideologicalEnum: IdeologicalEnum) -> [SignStruct] {
        switch ideologicalEnum {
        case .logicalMale:
            return [bullSign, snakeSign, roosterSign]
        case .logicalFemale:
            return [tigerSign, horseSign, dogSign]
        case .strongWilledMale:
            return [tigerSign, horseSign, dogSign]
        case .strongWilledFemale:
            return [bullSign, snakeSign, roosterSign]
        case .mysticalMale:
            return [ratSign, monkeySign, dragonSign]
        case .mysticalFemale:
            return [catSign, goatSign, boarSign]
        case .realisticMale:
            return [catSign, goatSign, boarSign]
        case .realisticFemale:
            return [ratSign, monkeySign, dragonSign]
        }
    }
    
    func psychologicalSigns(psychologicalEnum: PsychologicalEnum) -> [SignStruct] {
        switch psychologicalEnum {
        case .maturity:
            return [boarSign, ratSign, bullSign]
        case .dreamer:
            return [tigerSign, catSign, dragonSign]
        case .sensitive:
            return [snakeSign, horseSign, goatSign]
        case .grounded:
            return [monkeySign, roosterSign, dogSign]
        }
    }
    
    func energySigns(energy: EnergyEnum) -> [SignStruct] {
        switch energy {
        case .dramatic:
            return [goatSign, ratSign, snakeSign]
        case .sanguine:
            return [bullSign, horseSign, boarSign]
        case .phlegmatic:
            return [tigerSign, roosterSign, dragonSign]
        case .melancholic:
            return [monkeySign, catSign, dogSign]
        }
    }
    
    func fateSigns(fate: FateEnum) -> [SignStruct] {
        switch fate {
        case .fatalist:
            return [ratSign, tigerSign, dogSign]
        case .lucky:
            return [catSign, snakeSign, bullSign]
        case .doItYourself:
            return [horseSign, monkeySign, dragonSign]
        case .pioneer:
            return [boarSign, roosterSign, goatSign]
        }
    }
    
    func ourBusinessRelationship(customer: ClientStruct) -> BusinessEnum {
        return mainUser.annualSignStruct.businessStruct.filter{$0.key == customer.annualSignStruct.annualSign}.first!.value
    }
    
    func getAnnualSign(date: Date) -> SignStruct? {
        let dateComponents = Calendar.current.dateComponents([.year], from: date)
        let year = dateComponents.year
        for i in annualSignArray {
            if i.years.contains(year!) {
                return i
            }
        }
        return nil
    }
    
    func getZodiacSign(date: Date) -> ZodiacEnum? {
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
        let day = dateComponents.day
        let month = dateComponents.month
        
        for i in zodiacArray {
            for e in i.days {
                if e.key == month && e.value.contains(day!) {
                    return i.sign
                }
            }
        }
        return nil
    }
    
    func getAge(birthdate: Date) -> Int {
        let birthDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: birthdate)
        let actualDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        var age = actualDateComponents.year! - birthDateComponents.year!
        
        if birthDateComponents.month! - actualDateComponents.month! < 0 {
            age += 1
            return age
        } else if birthDateComponents.month! - actualDateComponents.month! == 0 {
            if birthDateComponents.day! - actualDateComponents.day! < 1 {
                age += 1
                return age
            }
        }
        return age
    }
    
    func getAgeType(birthdate: Date) -> AgeEnum {
        let age = getAge(birthdate: birthdate)
        switch age {
        case 0...1:
            return .newborn
        case 2...3:
            return .baby
        case 4...7:
            return .preschooler
        case 8...12:
            return .juniorSchoolStudent
        case 13...17:
            return .teacher
        case 18...24:
            return .youth
        case 25...31:
            return .intellectual
        case 32...42:
            return .trailblazer
        case 43...55:
            return .success
        case 56...70:
            return .teacher
        case 71...85:
            return .triumphant
        case 86...200:
            return .outgoing
        default:
            return .newborn
        }
    }
    
    func eventDescription(dayType: [AnnualEnum: DayType]) -> String {
        return dayType.map{"\(annualSigns[$0.key]!.emoji.rawValue) \($0.key.rawValue): \($0.value.emoji) \($0.value.title)"}.joined(separator: "\n")
    }
    
    func addAllEventsToCalendar() {
        let endDate = Date().adding(.year, value: 50)
        addEventToCalendar(title: "\(firstDay[mainUser.annualSignStruct.annualSign]!.emoji) \(firstDay[mainUser.annualSignStruct.annualSign]!.title)", description: eventDescription(dayType: firstDay), startDate: startingDate(day: 9), endDate: endDate)
        addEventToCalendar(title: "\(secondDay[mainUser.annualSignStruct.annualSign]!.emoji) \(secondDay[mainUser.annualSignStruct.annualSign]!.title)", description: eventDescription(dayType: secondDay), startDate: startingDate(day: 10), endDate: endDate)
        addEventToCalendar(title: "\(thirdDay[mainUser.annualSignStruct.annualSign]!.emoji) \(thirdDay[mainUser.annualSignStruct.annualSign]!.title)", description: eventDescription(dayType: thirdDay), startDate: startingDate(day: 11), endDate: endDate)
        addEventToCalendar(title: "\(fourthDay[mainUser.annualSignStruct.annualSign]!.emoji) \(fourthDay[mainUser.annualSignStruct.annualSign]!.title)", description: eventDescription(dayType: fourthDay), startDate: startingDate(day: 12), endDate: endDate)
        addEventToCalendar(title: "\(fifthDay[mainUser.annualSignStruct.annualSign]!.emoji) \(fifthDay[mainUser.annualSignStruct.annualSign]!.title)", description: eventDescription(dayType: fifthDay), startDate: startingDate(day: 13), endDate: endDate)
        addEventToCalendar(title: "\(sixthDay[mainUser.annualSignStruct.annualSign]!.emoji) \(sixthDay[mainUser.annualSignStruct.annualSign]!.title)", description: eventDescription(dayType: sixthDay), startDate: startingDate(day: 14), endDate: endDate)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.addEventToCalendar(title: "\(seventhDay[self.mainUser.annualSignStruct.annualSign]!.emoji) \(seventhDay[self.mainUser.annualSignStruct.annualSign]!.title)", description: self.eventDescription(dayType: seventhDay), startDate: self.startingDate(day: 15), endDate: endDate)
            self.addEventToCalendar(title: "\(eighthDay[self.mainUser.annualSignStruct.annualSign]!.emoji) \(eighthDay[self.mainUser.annualSignStruct.annualSign]!.title)", description: self.eventDescription(dayType: eighthDay), startDate: self.startingDate(day: 16), endDate: endDate)
            self.addEventToCalendar(title: "\(ninthDay[self.mainUser.annualSignStruct.annualSign]!.emoji) \(ninthDay[self.mainUser.annualSignStruct.annualSign]!.title)", description: self.eventDescription(dayType: ninthDay), startDate: self.startingDate(day: 17), endDate: endDate)
            self.addEventToCalendar(title: "\(tenthDay[self.mainUser.annualSignStruct.annualSign]!.emoji) \(tenthDay[self.mainUser.annualSignStruct.annualSign]!.title)", description: self.eventDescription(dayType: tenthDay), startDate: self.startingDate(day: 18), endDate: endDate)
            self.addEventToCalendar(title: "\(eleventhDay[self.mainUser.annualSignStruct.annualSign]!.emoji) \(eleventhDay[self.mainUser.annualSignStruct.annualSign]!.title)", description: self.eventDescription(dayType: eleventhDay), startDate: self.startingDate(day: 19), endDate: endDate)
            self.addEventToCalendar(title: "\(twelveDay[self.mainUser.annualSignStruct.annualSign]!.emoji) \(twelveDay[self.mainUser.annualSignStruct.annualSign]!.title)", description: self.eventDescription(dayType: twelveDay), startDate: self.startingDate(day: 20), endDate: endDate)
        }
        
    }
    
    func addEventToCalendar(title: String, description: String?, startDate: Date, endDate: Date, completion: ((_ success: Bool, _ error: NSError?) -> Void)? = nil) {
        let eventStore = EKEventStore()
        
        eventStore.requestAccess(to: .event, completion: { (granted, error) in
            if (granted) && (error == nil) {
                let event = EKEvent(eventStore: eventStore)
                event.title = title
                event.startDate = startDate
                event.endDate = startDate
                event.isAllDay = true
                event.notes = description
                
                event.calendar = eventStore.defaultCalendarForNewEvents
                
                let recurrenceRule = EKRecurrenceRule.init(
                    recurrenceWith: .daily,
                    interval: 12,
                    daysOfTheWeek: [EKRecurrenceDayOfWeek.init(EKWeekday.monday), EKRecurrenceDayOfWeek.init(EKWeekday.tuesday), EKRecurrenceDayOfWeek.init(EKWeekday.wednesday), EKRecurrenceDayOfWeek.init(EKWeekday.thursday), EKRecurrenceDayOfWeek.init(EKWeekday.friday), EKRecurrenceDayOfWeek.init(EKWeekday.saturday), EKRecurrenceDayOfWeek.init(EKWeekday.sunday)],
                    daysOfTheMonth: nil,
                    monthsOfTheYear: nil,
                    weeksOfTheYear: nil,
                    daysOfTheYear: nil,
                    setPositions: nil,
                    end: EKRecurrenceEnd.init(end:endDate)
                )
                
                event.recurrenceRules = [recurrenceRule]
                do {
                    try eventStore.save(event, span: .thisEvent)
                } catch let e as NSError {
                    completion?(false, e)
                    return
                }
                completion?(true, nil)
            } else {
                completion?(false, error as NSError?)
            }
        })
    }
    
    func eventsByPickedDate(pickedDate: Date) -> [DayStruct] {
        var dateComponents = DateComponents()
        dateComponents.year = 2020
        dateComponents.month = 1
        dateComponents.day = 2
        let calendar = Calendar(identifier: .gregorian)
        var mainDay = calendar.date(from: dateComponents)!
        let maxDay = Calendar.current.date(byAdding: .day, value: 3, to: pickedDate)!
        let minusThree = Calendar.current.date(byAdding: .day, value: -4, to: pickedDate)!
        let minDay = Calendar.current.date(byAdding: .day, value: -24, to: pickedDate)!
        
        
        repeat {
            mainDay = Calendar.current.date(byAdding: .day, value: 12, to: mainDay)!
        } while mainDay < minDay
        print(mainDay)
        
        var arr = [DayStruct]()
        var count = -1
        
        for dayType in days {
            arr.append(DayStruct(date: Calendar.current.date(byAdding: .day, value: count, to: mainDay)!, signs: dayType))
            count += 1
        }
        for dayType in days {
            arr.append(DayStruct(date: Calendar.current.date(byAdding: .day, value: count, to: mainDay)!, signs: dayType))
            count += 1
        }
        for dayType in days {
            arr.append(DayStruct(date: Calendar.current.date(byAdding: .day, value: count, to: mainDay)!, signs: dayType))
            count += 1
        }
        
        arr = arr.filter { event in
            event.date <= maxDay && event.date >= minusThree
        }
        arr.sort { event1, event2 in
            event1.date < event2.date
        }
        return arr
    }
    
    func extractDate(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
    
    func isToday(date: Date, pickedDate: Date) -> Bool {
        
        let calendar = Calendar.current
        
        return calendar.isDate(pickedDate, inSameDayAs: date)
    }
    
    func getEventFromEvents(events: [DayStruct], day: Date) -> DayStruct? {
        return events.filter { event in
            event.date == day
        }.first
    }
}
