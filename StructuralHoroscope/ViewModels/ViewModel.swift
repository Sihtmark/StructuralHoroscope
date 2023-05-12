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
//        let day = date.day()
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
    
    func createMainUser(name: String, sex: Sex, birthday: Date, sign: AnnualEnum, zodiacSign: ZodiacEnum) {
        let newMainUser = ClientStruct(
            name: name,
            birthday: birthday,
            sex: sex,
            annualSignStruct: annualSigns[sign]!,
            zodiacSign: sampleClient.zodiacSign
        )
        mainUser = newMainUser
    }
    
    func createNewCustomer(name: String, sex: Sex, birthday: Date, sign: AnnualEnum, zodiacSign: ZodiacEnum) {
        let newCustomer = ClientStruct(
            name: name,
            birthday: birthday,
            sex: sex,
            annualSignStruct: annualSigns[sign]!,
            zodiacSign: sampleClient.zodiacSign
        )
        customers.append(newCustomer)
    }
    
    func updateMainUser(name: String, sex: Sex, birthday: Date, sign: AnnualEnum, zodiacSign: ZodiacEnum) {
        if mainUser == sampleClient {
            createMainUser(name: name, sex: sex, birthday: birthday, sign: sign, zodiacSign: zodiacSign)
        } else {
            mainUser = mainUser.updateInfo(name: name, sex: sex, birthday: birthday, sign: annualSigns[sign]!, zodiacSign: zodiacSign)
        }
    }
    
    func updateCustomer(client: ClientStruct, name: String, sex: Sex, birthday: Date, sign: AnnualEnum, zodiacSign: ZodiacEnum) {
        if let index = customers.firstIndex(where: {$0.id == client.id}) {
            customers[index] = client.updateInfo(name: name, sex: sex, birthday: birthday, sign: annualSigns[sign]!, zodiacSign: zodiacSign)
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
    
    func clones(sign: SignStruct) -> String {
        return sign.clones.map{$0.rawValue}.joined(separator: ", ")
    }
    
    func companions(sign: SignStruct) -> String {
        return sign.companions.map{$0.rawValue}.joined(separator: ", ")
    }
    
    func subordinates(sign: SignStruct) -> String {
        return sign.subordinates.map{$0.rawValue}.joined(separator: ", ")
    }
    
    func advisers(sign: SignStruct) -> String {
        return sign.advisers.map{$0.rawValue}.joined(separator: ", ")
    }
    
    func vectorMarriage(sign: SignStruct) -> String {
        return sign.vectorMarriage.map{$0.rawValue}.joined(separator: ", ")
    }
    
    func romanticMarriage(sign: SignStruct) -> String {
        return sign.romanticMarriage.map{$0.rawValue}.joined(separator: ", ")
    }
    
    func equalMarriage(sign: SignStruct) -> String {
        return sign.equalMarriage.map{$0.rawValue}.joined(separator: ", ")
    }
    
    func spiritualMarriage(sign: SignStruct) -> String {
        return sign.spiritualMarriage.map{$0.rawValue}.joined(separator: ", ")
    }
    
    func patriarchalMarriage(sign: SignStruct) -> String {
        return sign.patriarchalMarriage.map{$0.rawValue}.joined(separator: ", ")
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
}
