//
//  AnnualSignInfo.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 13.04.2023.
//

import SwiftUI

struct AnnualSignInfo: View {
    
    @EnvironmentObject private var VM: ViewModel
    let sign: SignStruct
    
    var body: some View {
        List {
            typeSection
            vectorSection
            businessSection
            marriageSection
        }
        .listStyle(.grouped)
        .navigationTitle(sign.annualSign.rawValue)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Link(destination: URL(string: sign.site)!) {
                    Image(systemName: "globe")
                }
            }
        }
    }
}

struct AnnualSignInfo_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AnnualSignInfo(sign: annualSigns[0])
        }
        .environmentObject(ViewModel())
    }
}

extension AnnualSignInfo {
    var typeSection: some View {
        Section("Типы:") {
            Text("Тип мышления для мужчин: \(sign.ideologicalType[Sex.male]?.rawValue ?? "")")
            Text("Тип мышления для женщин: \(sign.ideologicalType[Sex.female]?.rawValue ?? "")")
            Text("Социальный тип: \(sign.socialType.rawValue)")
            Text("Психологический тип: \(sign.psychologicalType.rawValue)")
            Text("Энергетический тип: \(sign.temperament.rawValue)")
            Text("Тип судьбы: \(sign.fateType.rawValue)")
        }
    }
    var vectorSection: some View {
        Section("Векторы:") {
            Text("Хозяин: \(sign.vectorHost.rawValue)")
            Text("Слуга: \(sign.vectorServant.rawValue)")
        }
    }
    var businessSection: some View {
        Section("Бизнес:") {
            Text("Клоны: \(VM.clones(sign: sign))")
            Text("Соратники: \(VM.companions(sign: sign))")
            Text("Подчиненные: \(VM.subordinates(sign: sign))")
            Text("Советники: \(VM.advisers(sign: sign))")
        }
    }
    var marriageSection: some View {
        Section("Браки:") {
            Text("Романтический брак: \(VM.romantic(sign: sign))")
            Text("Патриархальный брак: \(VM.patriarchal(sign: sign))")
            Text("Равный брак: \(VM.equal(sign: sign))")
            Text("Духовный брак: \(VM.spiritual(sign: sign))")
        }
    }
}

