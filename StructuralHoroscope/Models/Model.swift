//
//  Model.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 31.03.2023.
//

import Foundation

struct ClientStruct: Identifiable, Codable, Equatable, Hashable {
    var id = UUID()
    var name: String
    var birthday: Date
    var sex: Sex
    var annualSignStruct: SignStruct
    var zodiacSign: ZodiacEnum
    var isFavorite: Bool
    
    func updateInfo(name: String, sex: Sex, birthday: Date, sign: SignStruct, zodiacSign: ZodiacEnum, isFavorite: Bool) -> ClientStruct {
        return ClientStruct(name: name, birthday: birthday, sex: sex, annualSignStruct: sign, zodiacSign: zodiacSign, isFavorite: isFavorite)
    }
}

struct VirtualSignStruct: Identifiable, Codable, Equatable, Hashable {
    var id = UUID()
    let virtualSign: VirtualEnum
    let emoji: VirtualEmojiEnum
    let blocks: [String:String]
}

struct SignStruct: Identifiable, Codable, Equatable, Hashable {
    var id = UUID()
    let annualSign: AnnualEnum
    let emoji: AnnualEmojiEnum
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

struct ZodiacStruct: Identifiable, Codable, Equatable, Hashable {
    var id = UUID()
    let sign: ZodiacEnum
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
    let signs: [AnnualEnum: [SignStruct]]
}

struct MarriageStruct: Identifiable, Codable, Equatable, Hashable {
    var id = UUID()
    let type: MarriageEnum
    let title: String
    let text: String
    let signs: [AnnualEnum: [SignStruct]]
}

struct SensualityStruct: Identifiable, Codable, Equatable, Hashable {
    var id = UUID()
    let department: SensualityEnum
    let zodiacs: [ZodiacEnum]
    let title: String
    let text: String
}

struct AgeStruct: Identifiable, Codable, Equatable, Hashable {
    var id = UUID()
    let sign: AgeEnum
    let title: String
    let ageTitle: String
    let ageСommandments: String
    let text: String
}

struct ElementStruct: Identifiable, Codable, Equatable, Hashable {
    var id = UUID()
    let element: ElementEnum
    let zodiacs: [ZodiacEnum]
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

enum Tab {
    case home
    case info
    case calendar
    case settings
}

struct DayType: Codable, Hashable, Identifiable {
    var id = UUID()
    let title: String
    let emoji: String
    let text: String?
}

enum ElementEnum: String, Codable, CaseIterable, Hashable {
    case fire = "Революционеры (Огонь)"
    case water = "Консерваторы (Вода)"
    case air = "Небожители (Воздух)"
    case earth = "Землепашцы (Земля)"
}

enum SensualityEnum: String, Codable, CaseIterable, Hashable {
    case coach = "Тренеры (Садо)"
    case athlete = "Спортсмены (Мазо)"
    case altruist = "Альтруисты (Повара)"
    case sybarite = "Сибариты (Гурманы)"
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

enum ZodiacEnum: String, Codable, CaseIterable, Hashable {
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

enum VirtualEnum: String, CaseIterable, Codable, Hashable {
    case king = "Король"
    case vector = "Вектор"
    case jester = "Шут"
    case knight = "Рыцарь"
    case aristocrat = "Аристократ"
    case professor = "Профессор"
    case leader = "Вождь"
}

enum VirtualEmojiEnum: String, CaseIterable, Codable, Hashable {
    case king = "👑"
    case vector = "↔️"
    case jester = "🤡"
    case knight = "⚔️"
    case aristocrat = "🎩"
    case professor = "👨‍🏫"
    case leader = "🗽"
}

enum AnnualEmojiEnum: String, CaseIterable, Codable, Hashable {
    case rat = "🐀"
    case bull = "🐂"
    case tiger = "🐅"
    case cat = "🐈"
    case dragon = "🐉"
    case snake = "🐍"
    case horse = "🐎"
    case goat = "🐐"
    case monkey = "🐒"
    case rooster = "🐓"
    case dog = "🐕"
    case boar = "🐗"
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
    case baby = "Младенеца 1-2"
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

let sampleClient = ClientStruct(
    name: "Зинаида",
    birthday: Date(),
    sex: .male,
    annualSignStruct: tigerSign,
    zodiacSign: .cancer,
    isFavorite: false
)
