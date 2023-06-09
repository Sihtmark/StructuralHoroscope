import Foundation

let sampleUser = UserStruct(birthday: Date(), sex: .male, annualSignStruct: horseSign, month: .february)

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
//        self.contact = contact?.updateInfo(distance: distance, component: component, reminder: reminder)
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
//        self.contact = contact!.updateLastContact(lastContact: date)
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
        
//        let updatedContact = contact.addMeeting(date: date, feeling: feeling, describe: describe)
//        self.contact = updatedContact
    }
}

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

struct SocialSignStruct: Identifiable, Codable, Equatable, Hashable {
    var id = UUID()
    let socialSign: SocialSignEnum
    let emoji: SocialEmojiEnum
    let blocks: [String:String]
}

struct AnnualSignStruct: Identifiable, Codable, Equatable, Hashable {
    var id = UUID()
    let annualSign: AnnualEnum
    let ideologicalType: [Sex: IdeologicalStruct]
    let socialType: SocialStruct
    let psychologicalType: PsychologicalStruct
    let temperament: EnergyStruct
    let fateType: FateStruct
    let ageType: AgeEnum
    let vectorHost: AnnualEnum
    let vectorServant: AnnualEnum
    let vectorMarriage: [AnnualEnum]
    let romanticMarriage: [AnnualEnum]
    let patriarchalMarriage: [AnnualEnum]
    let equalMarriage: [AnnualEnum]
    let spiritualMarriage: [AnnualEnum]
    let clones: [AnnualEnum]
    let companions: [AnnualEnum]
    let subordinates: [AnnualEnum]
    let advisers: [AnnualEnum]
    let socialSigns: [MonthEnum:SocialSignStruct]
    let businessStruct: [AnnualEnum: BusinessEnum]
    let blocks: [String:String]
    let years: [Int]
}

struct MonthStruct: Identifiable, Codable, Equatable, Hashable {
    var id = UUID()
    let sign: MonthEnum
    let days: [Int: ClosedRange<Int>]
}

struct IdeologicalStruct: Identifiable, Codable, Equatable, Hashable {
    var id = UUID()
    let ideologicalType: IdeologicalEnum
    let title: String
    let text: String
    let signs: [AnnualEnum]
}

struct SocialStruct: Identifiable, Codable, Equatable, Hashable {
    var id = UUID()
    let socialType: SocialEnum
    let signs: [AnnualEnum]
    let title: String
    let text: String
}

struct PsychologicalStruct: Identifiable, Codable, Equatable, Hashable {
    var id = UUID()
    let psychologicalType: PsychologicalEnum
    let signs: [AnnualEnum]
    let title: String
    let text: String
}

struct EnergyStruct: Identifiable, Codable, Equatable, Hashable {
    var id = UUID()
    let energyType: EnergyEnum
    let signs: [AnnualEnum]
    let title: String
    let text: String
}

struct FateStruct: Identifiable, Codable, Equatable, Hashable {
    var id = UUID()
    let fateType: FateEnum
    let signs: [AnnualEnum]
    let title: String
    let text: String
}

struct BusinessStruct: Identifiable, Codable, Equatable, Hashable {
    var id = UUID()
    let type: BusinessEnum
    let value: String
    let text: String
    let signs: [AnnualEnum: [AnnualSignStruct]]
}

struct MarriageStruct: Identifiable, Codable, Equatable, Hashable {
    var id = UUID()
    let type: MarriageEnum
    let title: String
    let text: String
    let signs: [AnnualEnum: [AnnualSignStruct]]
}

struct AgeStruct: Identifiable, Codable, Equatable, Hashable {
    var id = UUID()
    let sign: AgeEnum
    let title: String
    let ageTitle: String
    let ageСommandments: String
    let text: String
}

struct DayStruct: Identifiable, Codable, Hashable {
    var id = UUID()
    let date: Date
    let signs: [AnnualEnum: DayType]
    
    var dateComponents: DateComponents {
        var dateComponents = Calendar.current.dateComponents(
            [.month,
             .day,
             .year],
            from: date)
        dateComponents.timeZone = TimeZone.current
        dateComponents.calendar = Calendar(identifier: .gregorian)
        return dateComponents
    }
}

struct DayType: Codable, Hashable, Identifiable {
    var id = UUID()
    let title: String
    let emoji: String
    let text: String?
}

enum Tab {
    case home
    case info
    case calendar
}

enum AnnualEnum: String, Codable, CaseIterable, Hashable {
    case snake = "Змея"
    case horse = "Лошадь"
    case goat = "Коза"
    case monkey = "Обезьяна"
    case rooster = "Петух"
    case dog = "Собака"
    case boar = "Кабан"
    case rat = "Крыса"
    case bull = "Бык"
    case tiger = "Тигр"
    case cat = "Кот"
    case dragon = "Дракон"
}

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

enum SocialSignEnum: String, CaseIterable, Codable, Hashable {
    case king = "Король"
    case vector = "Вектор"
    case jester = "Шут"
    case knight = "Рыцарь"
    case aristocrat = "Аристократ"
    case professor = "Профессор"
    case leader = "Вождь"
}

enum SocialEmojiEnum: String, CaseIterable, Codable, Hashable {
    case king = "👑"
    case vector = "↔️"
    case jester = "🤡"
    case knight = "⚔️"
    case aristocrat = "🎩"
    case professor = "👨‍🏫"
    case leader = "🗽"
}

enum BusinessEnum: String, Codable, CaseIterable, Hashable {
    case vectorHost = "Векторный хозяин"
    case vectorServant = "Векторный слуга"
    case clone = "Клоны"
    case companion = "Соратники"
    case subordinate = "Подчиненные"
    case adviser = "Советники"
}

enum MarriageEnum: String, Codable, CaseIterable, Hashable {
    case vector = "Векторный брак"
    case romantic = "Романтический брак"
    case patriarchal = "Патриархальный брак"
    case equal = "Равный брак"
    case spiritual = "Духовный брак"
}

enum AgeEnum: String, Codable, CaseIterable, Hashable {
    case newborn = "Новорожденного 0"
    case baby = "Младенца 1-2"
    case preschooler = "Дошкольника 3-6"
    case juniorSchoolStudent = "Школьника 7-11"
    case teenager = "Подростка 12-17"
    case youth = "Студента 17-23"
    case intellectual = "Интелектуала 24-30"
    case trailblazer = "Новатора 31-41"
    case success = "Успешности 42-54"
    case teacher = "Учителя 55-70"
    case triumphant = "Триумфатора 70-84"
    case outgoing = "Уходящего 85 - ∞"
}

enum IdeologicalEnum: String, Codable, CaseIterable, Hashable {
    case logicalMale = "Мужская логика"
    case logicalFemale = "Женская логика"
    case strongWilledMale = "Мужская воля"
    case strongWilledFemale = "Женская воля"
    case mysticalMale = "Мужская мистика"
    case mysticalFemale = "Женская мистика"
    case realisticMale = "Мужской реализм"
    case realisticFemale = "Женский реализм"
}

enum SocialEnum: String, Codable, CaseIterable, Hashable {
    case closed = "Закрытый"
    case opened = "Открытый"
    case orthodox = "Ортодокс"
}

enum PsychologicalEnum: String, Codable, CaseIterable, Hashable {
    case maturity = "Возмужания"
    case dreamer = "Взлетый"
    case sensitive = "Чувствительный"
    case grounded = "Приземленный"
}

enum EnergyEnum: String, Codable, CaseIterable, Hashable {
    case dramatic = "Драматический"
    case sanguine = "Природный оптимист"
    case phlegmatic = "Космический оптимист"
    case melancholic = "Скептик"
}

enum FateEnum: String, Codable, CaseIterable, Hashable {
    case fatalist = "Фаталист"
    case lucky = "Везунчик"
    case doItYourself = "Самодельщик"
    case pioneer = "Пионер"
}

enum Sex: String, Codable, CaseIterable, Hashable {
    case male = "мужчины"
    case female = "женщины"
}

enum Components: String, Codable, CaseIterable, Hashable {
    case day = "день"
    case week = "неделя"
    case month = "месяц"
    case year = "год"
}

enum Feelings: String, Codable, CaseIterable, Hashable {
    case veryBad = "😡"
    case bad = "🙁"
    case notTooBad = "🤔"
    case good = "🙂"
    case veryGood = "😀"
}

enum FilterMainView: String, Codable, CaseIterable, Hashable {
    case standardOrder = "Без фильтра"
    case alphabeticalOrder = "По алфавиту"
    case dueDateOrder = "По дате общения"
    case favoritesOrder = "Избранные"
    case withoutTracker = "Без отслеживания"
}
