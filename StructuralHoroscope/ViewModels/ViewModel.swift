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
    
    
}
