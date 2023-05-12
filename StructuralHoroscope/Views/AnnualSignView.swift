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
            thinkingSection
            typeSection
            vectorSection
            businessSection
            marriageSection
            descriptionSection
        }
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
    var thinkingSection: some View {
        Section {
            NavigationLink {
                IdeologicalView(sign: sign.ideologicalType[.male]!)
            } label: {
                Text(sign.ideologicalType[Sex.male]!.ideologicalType.rawValue)
            }
            NavigationLink {
                IdeologicalView(sign: sign.ideologicalType[.female]!)
            } label: {
                Text(sign.ideologicalType[Sex.female]!.ideologicalType.rawValue)
            }
        }
    }
    var typeSection: some View {
        Section("Типы:") {
            NavigationLink {
                SocialView(social: sign.socialType)
            } label: {
                Text("Социальный тип: \(sign.socialType.socialType.rawValue)")
            }
            NavigationLink {
                PsychologicalView(psychologicalStruct: sign.psychologicalType)
            } label: {
                Text("Психологический тип: \(sign.psychologicalType.psychologicalType.rawValue)")
            }
            NavigationLink {
                EnergyView(energy: sign.temperament)
            } label: {
                Text("Энергетический тип: \(sign.temperament.energyType.rawValue)")
            }
            NavigationLink {
                FateView(fate: sign.fateType)
            } label: {
                Text("Тип судьбы: \(sign.fateType.fateType.rawValue)")
            }
            
        }
    }
    var vectorSection: some View {
        Section("Векторы:") {
            NavigationLink {
                AnnualSignView(sign: annualSigns[sign.vectorHost]!)
            } label: {
                Text("Хозяин: \(sign.vectorHost.rawValue)")
            }
            NavigationLink {
                AnnualSignView(sign: annualSigns[sign.vectorServant]!)
            } label: {
                Text("Слуга: \(sign.vectorServant.rawValue)")
            }
        }
    }
    var businessSection: some View {
        Section("Бизнес:") {
            NavigationLink {
                BusinessView(business: clone, sign: sign.annualSign)
            } label: {
                Text("Клоны: \(VM.clones(sign: sign))")
            }
            NavigationLink {
                BusinessView(business: companion, sign: sign.annualSign)
            } label: {
                Text("Соратники: \(VM.companions(sign: sign))")
            }
            NavigationLink {
                BusinessView(business: subordinate, sign: sign.annualSign)
            } label: {
                Text("Подчиненные: \(VM.subordinates(sign: sign))")
            }
            NavigationLink {
                BusinessView(business: adviser, sign: sign.annualSign)
            } label: {
                Text("Советники: \(VM.advisers(sign: sign))")
            }
        }
    }
    var marriageSection: some View {
        Section("Браки:") {
            NavigationLink {
                MarriageView(marriage: vectorMarriage, sign: sign.annualSign)
            } label: {
                Text("Векторный брак: \(VM.vectorMarriage(sign: sign))")
            }
            NavigationLink {
                MarriageView(marriage: romanticMarriage, sign: sign.annualSign)
            } label: {
                Text("Романтический брак: \(VM.romanticMarriage(sign: sign))")
            }
            NavigationLink {
                MarriageView(marriage: patriarchalMarriage, sign: sign.annualSign)
            } label: {
                Text("Патриархальный брак: \(VM.patriarchalMarriage(sign: sign))")
            }
            NavigationLink {
                MarriageView(marriage: equalMarriage, sign: sign.annualSign)
            } label: {
                Text("Равный брак: \(VM.equalMarriage(sign: sign))")
            }
            NavigationLink {
                MarriageView(marriage: spiritualMarriage, sign: sign.annualSign)
            } label: {
                Text("Духовный брак: \(VM.spiritualMarriage(sign: sign))")
            }
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

