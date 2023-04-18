//
//  ViewModel.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 12.04.2023.
//

import Foundation

class ViewModel: ObservableObject {
    
    func romantic(sign: SignStruct) -> String {
        return sign.romanticMarriage.map{$0.rawValue}.joined(separator: ", ")
    }
    
    func patriarchal(sign: SignStruct) -> String {
        return sign.patriarchalMarriage.map{$0.rawValue}.joined(separator: ", ")
    }
    
    func equal(sign: SignStruct) -> String {
        return sign.equalMarriage.map{$0.rawValue}.joined(separator: ", ")
    }
    
    func spiritual(sign: SignStruct) -> String {
        return sign.spiritualMarriage.map{$0.rawValue}.joined(separator: ", ")
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
}
