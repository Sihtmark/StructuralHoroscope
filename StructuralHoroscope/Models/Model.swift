//
//  Model.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 31.03.2023.
//

import Foundation

struct ClientStruct: Identifiable {
    let id = UUID()
    let name: String
    let birthday: Date
    let sex: Sex
    let sign: SignStruct
    let zodiacSign: ZodiacEnum
}

struct VirtualSignStruct: Identifiable {
    let id = UUID()
    let virtualSign: String
    let blocks: [String:String]
    let site: String
}

struct SignStruct: Identifiable {
    let id = UUID()
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
}

struct IdeologicalStruct: Identifiable {
    let id = UUID()
    let ideologicalType: IdeologicalEnum
    let title: String
    let text: String
}

struct SocialStruct: Identifiable {
    let id = UUID()
    let socialType: SocialEnum
    let title: String
    let text: String
}

struct PsychologicalStruct: Identifiable {
    let id = UUID()
    let psychologicalType: PsychologicalEnum
    let title: String
    let text: String
}

struct EnergyStruct: Identifiable {
    let id = UUID()
    let energyType: EnergyEnum
    let title: String
    let text: String
}

struct FateStruct: Identifiable {
    let id = UUID()
    let fateType: FateEnum
    let title: String
    let text: String
}

struct BusinessStruct: Identifiable {
    let id = UUID()
    let type: BusinessEnum
    let value: String
    let text: String
    let signs: [AnnualEnum: [SignStruct]]
}

struct MarriageStruct: Identifiable {
    let id = UUID()
    let type: MarriageEnum
    let title: String
    let text: String
    let signs: [AnnualEnum: [SignStruct]]
}

enum AnnualEnum: String {
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

enum ZodiacEnum: String {
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

enum VirtualEnum: String, CaseIterable {
    case king = "Король"
    case vector = "Вектор"
    case jester = "Шут"
    case knight = "Рыцарь"
    case aristocrat = "Аристократ"
    case professor = "Профессор"
    case leader = "Вождь"
}

enum BusinessEnum: String {
    case vectorHost = "Векторный хозяин"
    case vectorServant = "Векторный слуга"
    case clone = "Клоны"
    case companion = "Соратники"
    case subordinate = "Подчиненные"
    case adviser = "Советники"
}

enum MarriageEnum: String {
    case vector = "Векторный"
    case romantic = "Романтический"
    case patriarchal = "Патриархальный"
    case equal = "Равный"
    case spiritual = "Духовный"
}

enum AgeEnum: String {
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

enum IdeologicalEnum: String {
    case logicalMale = "Логик мужчина"
    case logicalFemale = "Логик женщина"
    case strongWilledMale = "Волевик мужчина"
    case strongWilledFemale = "Волевик женщина"
    case mysticalMale = "Мистик мужчина"
    case mysticalFemale = "Мистик женщина"
    case realisticMale = "Реалист мужчина"
    case realisticFemale = "Реалист женщина"
}

enum SocialEnum: String {
    case closed = "Закрытый"
    case opened = "Открытый"
    case orthodox = "Ортодокс"
}

enum PsychologicalEnum: String {
    case maturity = "Возмужания"
    case dreamer = "Взлетый"
    case sensitive = "Чувствительный"
    case grounded = "Приземленный"
}

enum EnergyEnum: String {
    case dramatic = "Драматический (холерик)"
    case sanguine = "Природный оптимист (сангвиник)"
    case phlegmatic = "Космический оптимист (флегматик)"
    case melancholic = "Скептик (меланхолик)"
}

enum FateEnum: String {
    case fatalist = "Фаталист"
    case lucky = "Везунчик"
    case doItYourself = "Самодельщик"
    case pioneer = "Пионер"
}

enum Sex: String {
    case male = "мужчины"
    case female = "женщины"
}


let sampleClient = ClientStruct(
    name: "Зинаида",
    birthday: Date(),
    sex: .male,
    sign: tigerSign,
    zodiacSign: .cancer)
