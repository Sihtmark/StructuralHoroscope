//
//  AnnualSignInfo.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 13.04.2023.
//

import SwiftUI

struct AnnualSignView: View {
    
    @EnvironmentObject private var vm: ViewModel
    let sign: SignStruct
    @State private var showDescription = false
    
    var body: some View {
        List {
            typeSection
            businessSection
            marriageSection
        }
        .navigationTitle(sign.annualSign.rawValue)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showDescription.toggle()
                } label: {
                    Image(systemName: "info.circle")
                }
            }
        }
        .sheet(isPresented: $showDescription) {
            annualSignDescription
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
        Section("Структура:") {
            NavigationLink {
                IdeologicalView(sign: sign.ideologicalType[.male]!)
            } label: {
                Text("🕺 \(sign.ideologicalType[Sex.male]!.ideologicalType.rawValue)")
            }
            NavigationLink {
                IdeologicalView(sign: sign.ideologicalType[.female]!)
            } label: {
                Text("💃 \(sign.ideologicalType[Sex.female]!.ideologicalType.rawValue)")
            }
            NavigationLink {
                SocialView(social: sign.socialType)
            } label: {
                Text("Социальный тип:\n\(sign.socialType.socialType.rawValue)")
                    .lineSpacing(6)
            }
            NavigationLink {
                PsychologicalView(psychologicalStruct: sign.psychologicalType)
            } label: {
                Text("Психологический тип:\n\(sign.psychologicalType.psychologicalType.rawValue)")
                    .lineSpacing(6)
            }
            NavigationLink {
                EnergyView(energy: sign.temperament)
            } label: {
                Text("Энергетический тип:\n\(sign.temperament.energyType.rawValue)")
                    .lineSpacing(6)
            }
            NavigationLink {
                FateView(fate: sign.fateType)
            } label: {
                Text("Тип судьбы:\n\(sign.fateType.fateType.rawValue)")
                    .lineSpacing(6)
            }
            
        }
    }
    
    var businessSection: some View {
        Section("Бизнес:") {
            NavigationLink {
                BusinessView(business: vectorHost, sign: sign.vectorHost)
            } label: {
                Text("Векторный хозяин:\n\(vm.hostString(sign: sign.vectorHost))")
                    .lineSpacing(6)
            }
            NavigationLink {
                BusinessView(business: vectorServant, sign: sign.vectorServant)
            } label: {
                Text("Векторный слуга:\n\(vm.servantString(sign: sign.vectorServant))")
                    .lineSpacing(6)
            }
            NavigationLink {
                BusinessView(business: clone, sign: sign.annualSign)
            } label: {
                Text("Клоны:\n\(vm.clones(sign: sign))")
                    .lineSpacing(6)
            }
            NavigationLink {
                BusinessView(business: companion, sign: sign.annualSign)
            } label: {
                Text("Соратники:\n\(vm.companions(sign: sign))")
                    .lineSpacing(6)
            }
            NavigationLink {
                BusinessView(business: subordinate, sign: sign.annualSign)
            } label: {
                Text("Подчиненные:\n\(vm.subordinates(sign: sign))")
                    .lineSpacing(6)
            }
            NavigationLink {
                BusinessView(business: adviser, sign: sign.annualSign)
            } label: {
                Text("Советники:\n\(vm.advisers(sign: sign))")
                    .lineSpacing(6)
            }
        }
    }
    
    var marriageSection: some View {
        Section("Браки:") {
            NavigationLink {
                MarriageView(marriage: vectorMarriage, sign: sign.annualSign)
            } label: {
                Text("Векторный:\n\(vm.vectorMarriage(sign: sign))")
                    .lineSpacing(6)
            }
            NavigationLink {
                MarriageView(marriage: romanticMarriage, sign: sign.annualSign)
            } label: {
                Text("Романтический:\n\(vm.romanticMarriage(sign: sign))")
                    .lineSpacing(6)
            }
            NavigationLink {
                MarriageView(marriage: patriarchalMarriage, sign: sign.annualSign)
            } label: {
                Text("Патриархальный:\n\(vm.patriarchalMarriage(sign: sign))")
                    .lineSpacing(6)
            }
            NavigationLink {
                MarriageView(marriage: equalMarriage, sign: sign.annualSign)
            } label: {
                Text("Равный:\n\(vm.equalMarriage(sign: sign))")
                    .lineSpacing(6)
            }
            NavigationLink {
                MarriageView(marriage: spiritualMarriage, sign: sign.annualSign)
            } label: {
                Text("Духовный:\n\(vm.spiritualMarriage(sign: sign))")
                    .lineSpacing(6)
            }
        }
    }
    
    var annualSignDescription: some View {
        VStack {
            HStack {
                Button {
                    showDescription.toggle()
                } label: {
                    Label("Назад", systemImage: "chevron.left")
                }
                Spacer()
            }
            .padding()
            ScrollView {
                ForEach(sign.blocks.sorted(by: <), id: \.key) { title, text in
                    VStack(alignment: .leading, spacing: 20) {
                        Text(title)
                            .font(.headline)
                            .bold()
                        Text(text)
                    }
                }
            }
        }
        .padding()
    }
}

