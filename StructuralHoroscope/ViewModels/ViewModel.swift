import SwiftUI
import EventKit

class ViewModel: ObservableObject {
    
    let nm = NotificationManager()
    
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
    
    func createNewContact(name: String, sex: Sex, birthday: Date, sign: AnnualSignStruct, zodiacSign: MonthEnum, distance: Int, component: Components, lastContact: Date, reminder: Bool, meetingTracker: Bool, feeling: Feelings, describe: String, isFavorite: Bool) {
        
        let newContact = EventStruct(
            distance: distance,
            component: component,
            lastContact: lastContact,
            reminder: reminder,
            allEvents: [ MeetingStruct(
                date: lastContact,
                feeling: feeling,
                describe: describe)
            ]
        )
        
        let newCustomer = ContactStruct(
            name: name,
            birthday: birthday,
            sex: sex,
            annualSignStruct: sign,
            month: zodiacSign,
            isFavorite: isFavorite,
            contact: meetingTracker ? newContact : nil
        )
        
        if meetingTracker && reminder {
            setNotification(contactStruct: newCustomer)
        }
        contacts.append(newCustomer)
    }
    
    func updateUser(sex: Sex, birthday: Date, sign: AnnualSignStruct, zodiacSign: MonthEnum) {
        if user == nil {
            createUser(sex: sex, birthday: birthday, sign: sign, zodiacSign: zodiacSign)
        } else {
            user!.updateInfo(sex: sex, birthday: birthday, sign: sign, month: zodiacSign)
        }
    }
    
    func updateContact(client: ContactStruct, name: String, sex: Sex, birthday: Date, sign: AnnualSignStruct, zodiacSign: MonthEnum, isFavorite: Bool, distance: Int, component: Components, lastContact: Date, reminder: Bool, meetingTracker: Bool, feeling: Feelings, describe: String) {
        if let index = contacts.firstIndex(where: {$0.id == client.id}) {
            if meetingTracker {
                if client.contact != nil {
                    contacts[index].updateInfo(name: name, sex: sex, birthday: birthday, sign: sign, month: zodiacSign, isFavorite: isFavorite, distance: distance, component: component, reminder: reminder)
                    saveContacts()
                } else {
                    contacts[index].updateAndCreateEvent(name: name, sex: sex, birthday: birthday, sign: sign, month: zodiacSign, isFavorite: isFavorite, distance: distance, component: component, lastContact: lastContact, reminder: reminder, feeling: feeling, describe: describe)
                    saveContacts()
                }
                if reminder {
                    setNotification(contactStruct: client)
                } else {
                    deleteNotification(contactStruct: client)
                }
            } else {
                if client.contact != nil {
                    contacts[index].updateInfoAndDeleteEvent(name: name, sex: sex, birthday: birthday, sign: sign, month: zodiacSign, isFavorite: isFavorite)
                } else {
                    contacts[index].updateWithoutEvent(name: name, sex: sex, birthday: birthday, sign: sign, month: zodiacSign, isFavorite: isFavorite)
                }
                deleteNotification(contactStruct: client)
            }
        }
        fetchContacts()
    }
    
    func updateEvent(contact: ContactStruct) {
        if let index = contacts.firstIndex(where: {$0.id == contact.id}) {
            contacts[index].changeLastContact(date: Date())
            setNotification(contactStruct: contact)
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
    
    func addAllEventsToCalendar() async {
        let endDate = Date().adding(.year, value: 50)
        addEventToCalendar(title: "\(firstDay[user!.annualSignStruct.annualSign]!.emoji) \(firstDay[user!.annualSignStruct.annualSign]!.title)", description: eventDescription(dayType: firstDay), startDate: startingDate(day: 9), endDate: endDate)
        addEventToCalendar(title: "\(secondDay[user!.annualSignStruct.annualSign]!.emoji) \(secondDay[user!.annualSignStruct.annualSign]!.title)", description: eventDescription(dayType: secondDay), startDate: startingDate(day: 10), endDate: endDate)
        addEventToCalendar(title: "\(thirdDay[user!.annualSignStruct.annualSign]!.emoji) \(thirdDay[user!.annualSignStruct.annualSign]!.title)", description: eventDescription(dayType: thirdDay), startDate: startingDate(day: 11), endDate: endDate)
        addEventToCalendar(title: "\(fourthDay[user!.annualSignStruct.annualSign]!.emoji) \(fourthDay[user!.annualSignStruct.annualSign]!.title)", description: eventDescription(dayType: fourthDay), startDate: startingDate(day: 12), endDate: endDate)
        addEventToCalendar(title: "\(fifthDay[user!.annualSignStruct.annualSign]!.emoji) \(fifthDay[user!.annualSignStruct.annualSign]!.title)", description: eventDescription(dayType: fifthDay), startDate: startingDate(day: 13), endDate: endDate)
        addEventToCalendar(title: "\(sixthDay[user!.annualSignStruct.annualSign]!.emoji) \(sixthDay[user!.annualSignStruct.annualSign]!.title)", description: eventDescription(dayType: sixthDay), startDate: startingDate(day: 14), endDate: endDate)
        addEventToCalendar(title: "\(seventhDay[user!.annualSignStruct.annualSign]!.emoji) \(seventhDay[user!.annualSignStruct.annualSign]!.title)", description: eventDescription(dayType: seventhDay), startDate: startingDate(day: 15), endDate: endDate)
        addEventToCalendar(title: "\(eighthDay[user!.annualSignStruct.annualSign]!.emoji) \(eighthDay[user!.annualSignStruct.annualSign]!.title)", description: eventDescription(dayType: eighthDay), startDate: startingDate(day: 16), endDate: endDate)
        addEventToCalendar(title: "\(ninthDay[user!.annualSignStruct.annualSign]!.emoji) \(ninthDay[user!.annualSignStruct.annualSign]!.title)", description: eventDescription(dayType: ninthDay), startDate: startingDate(day: 17), endDate: endDate)
        addEventToCalendar(title: "\(tenthDay[user!.annualSignStruct.annualSign]!.emoji) \(tenthDay[user!.annualSignStruct.annualSign]!.title)", description: eventDescription(dayType: tenthDay), startDate: startingDate(day: 18), endDate: endDate)
        try? await Task.sleep(for: .seconds(3))
        addEventToCalendar(title: "\(eleventhDay[user!.annualSignStruct.annualSign]!.emoji) \(eleventhDay[user!.annualSignStruct.annualSign]!.title)", description: eventDescription(dayType: eleventhDay), startDate: startingDate(day: 19), endDate: endDate)
        addEventToCalendar(title: "\(twelveDay[user!.annualSignStruct.annualSign]!.emoji) \(twelveDay[user!.annualSignStruct.annualSign]!.title)", description: eventDescription(dayType: twelveDay), startDate: startingDate(day: 20), endDate: endDate)
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
    
    func getDayCountFromLastContactToNext(component: Components, lastContact: Date, interval: Int) -> Int {
        let calendar = Calendar.current
        switch component {
        case .day:
            let nextContactDay = calendar.date(byAdding: Calendar.Component.day, value: interval, to: lastContact)!
            let distance = calendar.dateComponents([.day], from: lastContact, to: nextContactDay)
            return distance.day!
        case .week:
            let nextContactDay = calendar.date(byAdding: Calendar.Component.day, value: (interval * 7), to: lastContact)!
            let distance = calendar.dateComponents([.day], from: lastContact, to: nextContactDay)
            return distance.day!
        case .month:
            let nextContactDay = calendar.date(byAdding: Calendar.Component.month, value: interval, to: lastContact)!
            let distance = calendar.dateComponents([.day], from: lastContact, to: nextContactDay)
            return distance.day!
        case .year:
            let nextContactDay = calendar.date(byAdding: Calendar.Component.year, value: interval, to: lastContact)!
            let distance = calendar.dateComponents([.day], from: lastContact, to: nextContactDay)
            return distance.day!
        }
    }
    
    func daysFromLastEvent(lastEvent: Date, component: Components, lastContact: Date, Interval: Int) -> String {
        let calendar = Calendar.current
        let distance = calendar.dateComponents([.day], from: lastEvent, to: Date())
        let days = distance.day!
        var dayReminder: Int {
            if days < 20 {
                return days
            } else if days % 1000 >= 1 {
                return days % 1000
            } else if days % 100 >= 1 {
                return days % 100
            } else {
                return days % 10
            }
        }
        switch dayReminder {
        case 1:
            return "Прошел \(days) день из \(getDayCountFromLastContactToNext(component: component, lastContact: lastContact, interval: Interval))"
        case 2...4:
            return "Прошло \(days) дня из \(getDayCountFromLastContactToNext(component: component, lastContact: lastContact, interval: Interval))"
        case 11...19:
            return "Прошло \(days) дней из \(getDayCountFromLastContactToNext(component: component, lastContact: lastContact, interval: Interval))"
        default:
            return "Прошло \(days) дней из \(getDayCountFromLastContactToNext(component: component, lastContact: lastContact, interval: Interval))"
        }
    }
    
    func daysFromLastEventCell(lastEvent: Date, component: Components, lastContact: Date, Interval: Int) -> String {
        let calendar = Calendar.current
        let distance = calendar.dateComponents([.day], from: lastEvent, to: Date())
        let days = distance.day!
        return "\(days) / \(getDayCountFromLastContactToNext(component: component, lastContact: lastContact, interval: Interval))"
    }
    
    func updateMeeting(contact: ContactStruct, meeting: MeetingStruct, date: Date, feeling: Feelings, describe: String) {
        if let index = contacts.firstIndex(where: {$0.id == contact.id}) {
            if let i = contacts[index].contact!.allEvents.firstIndex(where: {$0.id == meeting.id}) {
                contacts[index].contact!.allEvents[i].date = date
                contacts[index].contact!.allEvents[i].feeling = feeling
                contacts[index].contact!.allEvents[i].describe = describe
            }
        }
    }
    
    func deleteMeeting(contact: ContactStruct, meeting: MeetingStruct) {
        if let index = contacts.firstIndex(where: {$0.id == contact.id}) {
            if let i = contacts[index].contact!.allEvents.firstIndex(where: {$0.id == meeting.id}) {
                contacts[index].contact!.allEvents.remove(at: i)
            }
        }
    }
    
    func toggleFavorite(contact: ContactStruct) {
        if let index = contacts.firstIndex(where: {$0.id == contact.id}) {
            contacts[index].isFavorite.toggle()
        }
    }
    
    func addMeeting(contact: ContactStruct, date: Date, feeling: Feelings, describe: String) {
        let newMeeting = MeetingStruct(date: date, feeling: feeling, describe: describe)
        if let index = contacts.firstIndex(where: {$0.id == contact.id}) {
            contacts[index].contact!.allEvents.append(newMeeting)
            contacts[index].contact!.lastContact = contacts[index].contact!.lastContact < date ? date : contacts[index].contact!.lastContact
            if contacts[index].contact!.reminder {
                setNotification(contactStruct: contacts[index])
            }
        }
    }
    
    func listOrder(order: FilterMainView) -> [ContactStruct] {
        switch order {
        case .standardOrder:
            return contacts
        case .alphabeticalOrder:
            return contacts.sorted(by: {$0.name > $1.name})
        case .dueDateOrder:
            return contacts.filter{$0.contact != nil}.sorted(by: {$0.contact!.getNextEventDate() < $1.contact!.getNextEventDate()})
        case .favoritesOrder:
            return contacts.filter{$0.isFavorite}
        case .withoutTracker:
            return contacts.filter{$0.contact == nil}
        }
    }
    
    func deleteNotification(contactStruct: ContactStruct) {
        nm.cancelNotification(id: contactStruct.id)
    }
    
    func setNotification(contactStruct: ContactStruct) {
        nm.cancelNotification(id: contactStruct.id)
        if let contact = contactStruct.contact {
            let date = getNextEventDate(component: contact.component, lastContact: contact.lastContact, interval: contact.distance)
            let calendar = Calendar.current
            let year = calendar.component(.year, from: date)
            let month = calendar.component(.month, from: date)
            let day = calendar.component(.day, from: date)
            nm.scheduleNotification(contact: contactStruct, year: year, month: month, day: day)
        }
    }
    
    func businessSigns(business: BusinessStruct, sign: AnnualEnum) -> String {
        return business.signs[sign]!.map{$0.annualSign.rawValue}.joined(separator: ", ")
    }
    
    func marriageSigns(marriage: MarriageStruct, sign: AnnualEnum) -> String {
        return marriage.signs[sign]!.map{$0.annualSign.rawValue}.joined(separator: ", ")
    }
}
