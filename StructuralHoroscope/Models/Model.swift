//
//  Model.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 31.03.2023.
//

import Foundation

struct ClientStruct: Identifiable, Codable, Equatable {
    var id = UUID()
    var name: String
    var birthday: Date
    var sex: Sex
    var annualSignStruct: SignStruct
    var zodiacSign: ZodiacEnum
    
    func updateInfo(name: String, sex: Sex, birthday: Date, sign: SignStruct, zodiacSign: ZodiacEnum) -> ClientStruct {
        return ClientStruct(name: name, birthday: birthday, sex: sex, annualSignStruct: sign, zodiacSign: zodiacSign)
    }
}

struct VirtualSignStruct: Identifiable, Codable, Equatable {
    var id = UUID()
    let virtualSign: String
    let blocks: [String:String]
    let site: String
}

struct SignStruct: Identifiable, Codable, Equatable {
    var id = UUID()
    let annualSign: AnnualEnum
    let site: String
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
    let virtualSigns: [ZodiacEnum:VirtualSignStruct]
    let businessStruct: [AnnualEnum: BusinessEnum]
    let blocks: [String:String]
    let years: [Int]
}

struct ZodiacStruct: Identifiable, Codable, Equatable {
    var id = UUID()
    let sign: ZodiacEnum
    let days: [Int: ClosedRange<Int>]
}

struct IdeologicalStruct: Identifiable, Codable, Equatable {
    var id = UUID()
    let ideologicalType: IdeologicalEnum
    let title: String
    let text: String
    let signs: [AnnualEnum]
}

struct SocialStruct: Identifiable, Codable, Equatable {
    var id = UUID()
    let socialType: SocialEnum
    let title: String
    let text: String
}

struct PsychologicalStruct: Identifiable, Codable, Equatable {
    var id = UUID()
    let psychologicalType: PsychologicalEnum
    let title: String
    let text: String
}

struct EnergyStruct: Identifiable, Codable, Equatable {
    var id = UUID()
    let energyType: EnergyEnum
    let title: String
    let text: String
}

struct FateStruct: Identifiable, Codable, Equatable {
    var id = UUID()
    let fateType: FateEnum
    let title: String
    let text: String
}

struct BusinessStruct: Identifiable, Codable, Equatable {
    var id = UUID()
    let type: BusinessEnum
    let value: String
    let text: String
    let signs: [AnnualEnum: [SignStruct]]
}

struct MarriageStruct: Identifiable, Codable, Equatable {
    var id = UUID()
    let type: MarriageEnum
    let title: String
    let text: String
    let signs: [AnnualEnum: [SignStruct]]
}

struct SensualityStruct: Identifiable, Codable, Equatable {
    var id = UUID()
    let department: SensualityEnum
    let zodiacs: [ZodiacEnum]
}

struct AgeStruct: Identifiable, Codable, Equatable {
    var id = UUID()
    let sign: AnnualEnum
    let title: String
    let ageTitle: String
    let ageСommandments: [String]
    let text: String
}

struct ElementStruct: Identifiable, Codable, Equatable {
    var id = UUID()
    let element: ElementEnum
    let zodiacs: [ZodiacEnum]
    let text: String
}

struct DayStruct: Identifiable, Codable {
    var id = UUID()
    let date: Date
    let signs: DayTypes
    
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

struct DayTypes: Identifiable, Codable {
    var id = UUID()
    let signs: [AnnualEnum: DayType]
}

enum Tab {
    case home
    case info
    case calendar
    case settings
}
        
enum DayType: String, Codable, CaseIterable {
    case blue = "Синий"
    case red = "Красный"
    case yellow = "Желтый"
    case green = "Зеленый"
    case orange = "Оранжевый"
    case easier = "Легче"
    case harder = "Труднее"
    case rest = "Отдых"
    case hangOut = "Потусуйтесь"
}

enum ElementEnum: String, Codable, CaseIterable {
    case fire = "Революционеры (Огонь)"
    case water = "Консерваторы (Вода)"
    case air = "Небожители (Воздух)"
    case earth = "Землепашцы (Земля)"
}

enum SensualityEnum: String, Codable, CaseIterable {
    case coach = "Тренеры (Садо)"
    case athlete = "Спортсмены (Мазо)"
    case altruist = "Альтруисты (Повара)"
    case sybarite = "Сибариты (Гурманы)"
}

enum AnnualEnum: String, Codable, CaseIterable {
    case snake = "Змея"
    case horse = "Лошадь"
    case goat = "Коза"
    case monkey = "Обезьяна"
    case rooster = "Петух"
    case dog = "Собака"
    case pig = "Кабан"
    case rat = "Крыса"
    case bull = "Бык"
    case tiger = "Тигр"
    case cat = "Кот"
    case dragon = "Дракон"
}

enum ZodiacEnum: String, Codable, CaseIterable {
    case aries = "Овен"
    case taurus = "Телец"
    case gemini = "Близнецы"
    case cancer = "Рак"
    case leo = "Лев"
    case virgo = "Дева"
    case libra = "Весы"
    case scorpio = "Скорпион"
    case sagittarius = "Стрелец"
    case capricorn = "Козерог"
    case aquarius = "Водолей"
    case pisces = "Рыбы"
}

enum VirtualEnum: String, CaseIterable, Codable {
    case king = "Король"
    case vector = "Вектор"
    case jester = "Шут"
    case knight = "Рыцарь"
    case aristocrat = "Аристократ"
    case professor = "Профессор"
    case leader = "Вождь"
}

enum BusinessEnum: String, Codable, CaseIterable {
    case vectorHost = "Векторный хозяин"
    case vectorServant = "Векторный слуга"
    case clone = "Клон"
    case companion = "Соратник"
    case subordinate = "Подчиненный"
    case adviser = "Начальник"
}

enum MarriageEnum: String, Codable, CaseIterable {
    case vector = "Векторный"
    case romantic = "Романтический"
    case patriarchal = "Патриархальный"
    case equal = "Равный"
    case spiritual = "Духовный"
}

enum AgeEnum: String, Codable, CaseIterable {
    case newborn = "Новорожденного 0-1"
    case baby = "Младенеца 1-3"
    case preschooler = "Дошкольника 3-7"
    case juniorSchoolStudent = "Школьника 7-12"
    case teenager = "Подростка 12-17"
    case youth = "Студента 17-24"
    case intellectual = "Интелектуала 24-31"
    case trailblazer = "Новатора 31-42"
    case success = "Успешности 42-55"
    case teacher = "Учителя 55-70"
    case triumphant = "Триумфатора 70-85"
    case outgoing = "Уходящего 85 - ∞"
}

enum IdeologicalEnum: String, Codable, CaseIterable {
    case logicalMale = "Логик мужчина"
    case logicalFemale = "Логик женщина"
    case strongWilledMale = "Волевик мужчина"
    case strongWilledFemale = "Волевик женщина"
    case mysticalMale = "Мистик мужчина"
    case mysticalFemale = "Мистик женщина"
    case realisticMale = "Реалист мужчина"
    case realisticFemale = "Реалист женщина"
}

enum SocialEnum: String, Codable, CaseIterable {
    case closed = "Закрытый"
    case opened = "Открытый"
    case orthodox = "Ортодокс"
}

enum PsychologicalEnum: String, Codable, CaseIterable {
    case maturity = "Возмужания"
    case dreamer = "Взлетый"
    case sensitive = "Чувствительный"
    case grounded = "Приземленный"
}

enum EnergyEnum: String, Codable, CaseIterable {
    case dramatic = "Драматический (холерик)"
    case sanguine = "Природный оптимист (сангвиник)"
    case phlegmatic = "Космический оптимист (флегматик)"
    case melancholic = "Скептик (меланхолик)"
}

enum FateEnum: String, Codable, CaseIterable {
    case fatalist = "Фаталист"
    case lucky = "Везунчик"
    case doItYourself = "Самодельщик"
    case pioneer = "Пионер"
}

enum Sex: String, Codable, CaseIterable {
    case male = "мужчины"
    case female = "женщины"
}

enum ThemeEnum: String, CaseIterable {
    case light = "Всегда светлая"
    case dark = "Всегда тёмная"
    case settings = "Настройки телефона"
}

let sampleClient = ClientStruct(
    name: "Зинаида",
    birthday: Date(),
    sex: .male,
    annualSignStruct: tigerSign,
    zodiacSign: .cancer)
