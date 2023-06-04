import Foundation
import EventKit

class ViewModel: ObservableObject {
    
    @Published var actualDayType: DayStruct?
    @Published var user: UserStruct? = nil {
        didSet {
            saveUser()
        }
    }
    @Published var contacts = [ContactStruct]() {
        didSet {
            saveContacts()
        }
    }
    
    let contactsKey = "items_list"
    let userKey = "main_user"
    
    init() {
        fetchUser()
        fetchContacts()
        getActualDayType()
    }
    
    func fetchUser() {
        guard let mainUserData = UserDefaults.standard.data(forKey: userKey), let savedMainUser = try? JSONDecoder().decode(UserStruct.self, from: mainUserData) else {return}
        self.user = savedMainUser
    }
    
    func fetchContacts() {
        guard let data = UserDefaults.standard.data(forKey: contactsKey), let savedItems = try? JSONDecoder().decode([ContactStruct].self, from: data) else {return}
        self.contacts = savedItems
    }
    
    func startingDate(day: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = 2023
        dateComponents.month = 5
        dateComponents.day = day
        let calendar = Calendar(identifier: .gregorian)
        return calendar.date(from: dateComponents)!
    }
    
    func saveUser() {
        if let encodedData = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encodedData, forKey: userKey)
        }
    }
    
    func saveContacts() {
        if let encodedData = try? JSONEncoder().encode(contacts) {
            UserDefaults.standard.set(encodedData, forKey: contactsKey)
        }
    }
    
    func createUser(sex: Sex, birthday: Date, sign: AnnualSignStruct, zodiacSign: MonthEnum) {
        let newMainUser = UserStruct(
            birthday: birthday,
            sex: sex,
            annualSignStruct: sign,
            month: sampleContact.month
        )
        user = newMainUser
    }
    
    func createNewContact(name: String, sex: Sex, birthday: Date, sign: AnnualSignStruct, zodiacSign: MonthEnum, distance: Int, component: Components, lastContact: Date, reminder: Bool, meetingTracker: Bool) {
        let newContact = EventStruct(distance: distance, component: component, lastContact: lastContact, reminder: reminder)
        let newCustomer = ContactStruct(
            name: name,
            birthday: birthday,
            sex: sex,
            annualSignStruct: sign,
            month: zodiacSign,
            isFavorite: false,
            contact: meetingTracker ? newContact : nil
        )
        contacts.append(newCustomer)
    }
    
    func updateUser(sex: Sex, birthday: Date, sign: AnnualSignStruct, zodiacSign: MonthEnum) {
        if user == nil {
            createUser(sex: sex, birthday: birthday, sign: sign, zodiacSign: zodiacSign)
        } else {
            user = user!.updateInfo(sex: sex, birthday: birthday, sign: sign, month: zodiacSign)
        }
    }
    
    func updateContact(client: ContactStruct, name: String, sex: Sex, birthday: Date, sign: AnnualSignStruct, zodiacSign: MonthEnum) {
        if let index = contacts.firstIndex(where: {$0.id == client.id}) {
            contacts[index] = client.updateInfo(name: name, sex: sex, birthday: birthday, sign: sign, month: zodiacSign, isFavorite: false)
            saveContacts()
        }
        fetchContacts()
    }
    
    func updateEvent(contact: ContactStruct) {
        if let index = contacts.firstIndex(where: {$0.id == contact.id}) {
            contacts[index] = contact.changeLastContact(date: Date())
        }
    }
    
    func deleteContact(indexSet: IndexSet) {
        contacts.remove(atOffsets: indexSet)
    }
    
    func moveContact(from: IndexSet, to: Int) {
        contacts.move(fromOffsets: from, toOffset: to)
    }
    
    func socialSigns(socialEnum: SocialEnum) -> [AnnualSignStruct] {
        switch socialEnum {
        case .opened:
            return [ratSign, catSign, horseSign, roosterSign]
        case .closed:
            return [tigerSign, snakeSign, monkeySign, boarSign]
        case .orthodox:
            return [bullSign, dragonSign, goatSign, dogSign]
        }
    }
    
    func ideologicalSigns(ideologicalEnum: IdeologicalEnum) -> [AnnualSignStruct] {
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
    
    func psychologicalSigns(psychologicalEnum: PsychologicalEnum) -> [AnnualSignStruct] {
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
    
    func energySigns(energy: EnergyEnum) -> [AnnualSignStruct] {
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
    
    func fateSigns(fate: FateEnum) -> [AnnualSignStruct] {
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
    
    func ourBusinessRelationship(customer: ContactStruct) -> BusinessEnum {
        return user!.annualSignStruct.businessStruct.filter{$0.key == customer.annualSignStruct.annualSign}.first!.value
    }
    
    func getAnnualSign(date: Date) -> AnnualSignStruct? {
        let birthDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
        let year = birthDateComponents.year!
        let month = birthDateComponents.month!
        let day = birthDateComponents.day!
        if Double(year).truncatingRemainder(dividingBy: 2.0) == 0 {
            for sign in annualSignArray {
                for e in sign.years {
                    if e == year {
                        return sign
                    }
                }
            }
        } else {
            if month > 1 {
                for sign in annualSignArray {
                    for e in sign.years {
                        if e == year {
                            return sign
                        }
                    }
                }
            } else {
                if day > 12 {
                    for sign in annualSignArray {
                        for e in sign.years {
                            if e == year {
                                return sign
                            }
                        }
                    }
                } else {
                    let newYear = year - 1
                    for sign in annualSignArray {
                        for e in sign.years {
                            if e == newYear {
                                return sign
                            }
                        }
                    }
                }
            }
        }
        return nil
    }
    
    func getMonth(date: Date) -> MonthEnum? {
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
        let day = dateComponents.day
        let month = dateComponents.month
        
        for i in months {
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
    
    func returnBusinessSing(sign: BusinessEnum) -> String {
        switch sign {
        case .vectorHost:
            return "Векторный хозяин"
        case .vectorServant:
            return "Векторный слуга"
        case .clone:
            return "Клон"
        case .companion:
            return "Соратник"
        case .subordinate:
            return "Подчиненный"
        case .adviser:
            return "Советник"
        }
    }
    
    func eventDescription(dayType: [AnnualEnum: DayType]) -> String {
        return dayType.map{"\($0.value.emoji)   \($0.key.rawValue)"}.joined(separator: "\n")
    }
    
    func addAllEventsToCalendar() {
        let endDate = Date().adding(.year, value: 50)
        addEventToCalendar(title: "\(firstDay[user!.annualSignStruct.annualSign]!.emoji) \(firstDay[user!.annualSignStruct.annualSign]!.title)", description: eventDescription(dayType: firstDay), startDate: startingDate(day: 9), endDate: endDate)
        addEventToCalendar(title: "\(secondDay[user!.annualSignStruct.annualSign]!.emoji) \(secondDay[user!.annualSignStruct.annualSign]!.title)", description: eventDescription(dayType: secondDay), startDate: startingDate(day: 10), endDate: endDate)
        addEventToCalendar(title: "\(thirdDay[user!.annualSignStruct.annualSign]!.emoji) \(thirdDay[user!.annualSignStruct.annualSign]!.title)", description: eventDescription(dayType: thirdDay), startDate: startingDate(day: 11), endDate: endDate)
        addEventToCalendar(title: "\(fourthDay[user!.annualSignStruct.annualSign]!.emoji) \(fourthDay[user!.annualSignStruct.annualSign]!.title)", description: eventDescription(dayType: fourthDay), startDate: startingDate(day: 12), endDate: endDate)
        addEventToCalendar(title: "\(fifthDay[user!.annualSignStruct.annualSign]!.emoji) \(fifthDay[user!.annualSignStruct.annualSign]!.title)", description: eventDescription(dayType: fifthDay), startDate: startingDate(day: 13), endDate: endDate)
        addEventToCalendar(title: "\(sixthDay[user!.annualSignStruct.annualSign]!.emoji) \(sixthDay[user!.annualSignStruct.annualSign]!.title)", description: eventDescription(dayType: sixthDay), startDate: startingDate(day: 14), endDate: endDate)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.addEventToCalendar(title: "\(seventhDay[self.user!.annualSignStruct.annualSign]!.emoji) \(seventhDay[self.user!.annualSignStruct.annualSign]!.title)", description: self.eventDescription(dayType: seventhDay), startDate: self.startingDate(day: 15), endDate: endDate)
            self.addEventToCalendar(title: "\(eighthDay[self.user!.annualSignStruct.annualSign]!.emoji) \(eighthDay[self.user!.annualSignStruct.annualSign]!.title)", description: self.eventDescription(dayType: eighthDay), startDate: self.startingDate(day: 16), endDate: endDate)
            self.addEventToCalendar(title: "\(ninthDay[self.user!.annualSignStruct.annualSign]!.emoji) \(ninthDay[self.user!.annualSignStruct.annualSign]!.title)", description: self.eventDescription(dayType: ninthDay), startDate: self.startingDate(day: 17), endDate: endDate)
            self.addEventToCalendar(title: "\(tenthDay[self.user!.annualSignStruct.annualSign]!.emoji) \(tenthDay[self.user!.annualSignStruct.annualSign]!.title)", description: self.eventDescription(dayType: tenthDay), startDate: self.startingDate(day: 18), endDate: endDate)
            self.addEventToCalendar(title: "\(eleventhDay[self.user!.annualSignStruct.annualSign]!.emoji) \(eleventhDay[self.user!.annualSignStruct.annualSign]!.title)", description: self.eventDescription(dayType: eleventhDay), startDate: self.startingDate(day: 19), endDate: endDate)
            self.addEventToCalendar(title: "\(twelveDay[self.user!.annualSignStruct.annualSign]!.emoji) \(twelveDay[self.user!.annualSignStruct.annualSign]!.title)", description: self.eventDescription(dayType: twelveDay), startDate: self.startingDate(day: 20), endDate: endDate)
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
    
    func getActualDayType() {
        let arr = eventsByPickedDate(pickedDate: Date())
        actualDayType = arr[Int((Double(arr.count) / 2.0).rounded(.up)) - 1]
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
        let range: ClosedRange<Date> = minusThree...maxDay
        
        repeat {
            mainDay = Calendar.current.date(byAdding: .day, value: 12, to: mainDay)!
        } while mainDay < minDay
        
        var arr = [DayStruct]()
        var count = -1
        
        for _ in 1...3 {
            for dayType in days {
                arr.append(DayStruct(date: Calendar.current.date(byAdding: .day, value: count, to: mainDay)!, signs: dayType))
                count += 1
            }
        }
        
        arr = arr.filter { event in
            range.contains(event.date)
        }
        
        arr.sort { event1, event2 in
            event1.date < event2.date
        }
        
        if arr.count > 7 {
            arr.removeFirst()
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
    
    func getNextEventDate(component: Components, lastContact: Date, interval: Int) -> Date {
        switch component {
        case .day:
            return Calendar.current.date(byAdding: Calendar.Component.day, value: interval, to: lastContact)!
        case .week:
            return Calendar.current.date(byAdding: Calendar.Component.day, value: (interval * 7), to: lastContact)!
        case .month:
            return Calendar.current.date(byAdding: Calendar.Component.month, value: interval, to: lastContact)!
        case .year:
            return Calendar.current.date(byAdding: Calendar.Component.year, value: interval, to: lastContact)!
        }
    }
}
