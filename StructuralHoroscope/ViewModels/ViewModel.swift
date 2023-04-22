//
//  ViewModel.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 12.04.2023.
//

import Foundation

class ViewModel: ObservableObject {
    
    @Published var customers = [ClientStruct]()
    
    func createNewCustomer(name: String, sex: Sex, birthday: Date) {
        let newCustomer = ClientStruct(
            name: name,
            birthday: birthday,
            sex: sex,
            sign: sampleClient.sign,
            zodiacSign: sampleClient.zodiacSign
        )
        customers.append(newCustomer)
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
