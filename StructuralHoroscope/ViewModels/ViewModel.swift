//
//  ViewModel.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 12.04.2023.
//

import Foundation

class ViewModel: ObservableObject {
    
    @Published var events = [DayStruct]()
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
        asdf()
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
        dateComponents.year = 2020
        dateComponents.month = 1
        dateComponents.day = day
        let calendar = Calendar(identifier: .gregorian)
        return calendar.date(from: dateComponents)!
    }
    
    func asdf() {
        var dayCount = 1
        var date = startingDate(day: dayCount)
        let endDate = Date().adding(.year, value: 12)
        for i in days {
            repeat {
                date = date.addDate()
                events.append(DayStruct(date: date, signs: i))
            } while date <= endDate
            dayCount += 1
            date = startingDate(day: dayCount)
        }
        
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
            return [tigerSign, snakeSign, monkeySign, pigSign]
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
            return [catSign, goatSign, pigSign]
        case .realisticMale:
            return [catSign, goatSign, pigSign]
        case .realisticFemale:
            return [ratSign, monkeySign, dragonSign]
        }
    }
    
    func psychologicalSigns(psychologicalEnum: PsychologicalEnum) -> [SignStruct] {
        switch psychologicalEnum {
        case .maturity:
            return [pigSign, ratSign, bullSign]
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
            return [bullSign, horseSign, pigSign]
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
            return [pigSign, roosterSign, goatSign]
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
}
