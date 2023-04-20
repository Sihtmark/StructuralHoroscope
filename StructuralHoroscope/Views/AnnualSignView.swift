//
//  AnnualSignInfo.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 13.04.2023.
//

import SwiftUI

struct AnnualSignView: View {
    
    @EnvironmentObject private var VM: ViewModel
    let sign: SignStruct
    
    var body: some View {
        List {
            typeSection
            vectorSection
            businessSection
            marriageSection
            descriptionSection
        }
        .listStyle(.plain)
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
            AnnualSignView(sign: annualSigns[.rat]!)
        }
        .environmentObject(ViewModel())
    }
}

extension AnnualSignView {
    var typeSection: some View {
        Section("Типы:") {
            Text("Тип мышления для мужчин: \(sign.ideologicalType[Sex.male]!.ideologicalType.rawValue)")
            Text("Тип мышления для женщин: \(sign.ideologicalType[Sex.female]!.ideologicalType.rawValue)")
            Text("Социальный тип: \(sign.socialType.socialType.rawValue)")
            Text("Психологический тип: \(sign.psychologicalType.psychologicalType.rawValue)")
            Text("Энергетический тип: \(sign.temperament.energyType.rawValue)")
            Text("Тип судьбы: \(sign.fateType.fateType.rawValue)")
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
            Text("Романтический брак: \(VM.romanticMarriage(sign: sign))")
            Text("Патриархальный брак: \(VM.patriarchalMarriage(sign: sign))")
            Text("Равный брак: \(VM.equalMarriage(sign: sign))")
            Text("Духовный брак: \(VM.spiritualMarriage(sign: sign))")
        }
    }
    var descriptionSection: some View {
        ForEach(sign.blocks.sorted(by: <), id: \.key) { title, text in
            Section(title) {
                Text(text)
            }
        }
    }
}

