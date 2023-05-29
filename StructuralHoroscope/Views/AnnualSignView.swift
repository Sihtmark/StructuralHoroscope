//
//  AnnualSignView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 13.04.2023.
//

import SwiftUI

struct AnnualSignView: View {
    
    @EnvironmentObject private var vm: ViewModel
    let sign: SignStruct
    @State private var showAnnualSignDescription = false
    
    var body: some View {
        List {
            typeSection
            businessSection
            marriageSection
        }
        .listStyle(.inset)
        .navigationTitle(sign.annualSign.rawValue)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showAnnualSignDescription.toggle()
                } label: {
                    Image(systemName: "info.circle")
                }
            }
        }
        .sheet(isPresented: $showAnnualSignDescription) {
            annualSignDescription
        }
    }
}

struct AnnualSignInfo_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AnnualSignView(sign: annualSigns[.rat]!)
                .preferredColorScheme(.dark)
        }
        .environmentObject(ViewModel())
        NavigationStack {
            AnnualSignView(sign: annualSigns[.rat]!)
                .preferredColorScheme(.light)
        }
        .environmentObject(ViewModel())
    }
}

extension AnnualSignView {
    
    var typeSection: some View {
        Section {
            NavigationLink {
                maleIdeologicDescription
            } label: {
                Text(sign.ideologicalType[Sex.male]!.ideologicalType.rawValue)
                    .foregroundColor(.theme.standard)
            }
            NavigationLink {
                femaleIdeologicDescription
            } label: {
                Text(sign.ideologicalType[Sex.female]!.ideologicalType.rawValue)
                    .foregroundColor(.theme.standard)
            }
            NavigationLink {
                socialDescription
            } label: {
                Text("Социальный тип: \(sign.socialType.socialType.rawValue)")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
            NavigationLink {
                psychologicalDescription
            } label: {
                Text("Психологический тип: \(sign.psychologicalType.psychologicalType.rawValue)")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
            NavigationLink {
                energyDescription
            } label: {
                Text("Энергетический тип: \(sign.temperament.energyType.rawValue)")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
            NavigationLink {
                fateDescription
            } label: {
                Text("Тип судьбы: \(sign.fateType.fateType.rawValue)")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
        } header: {
            Text("Структура:")
                .foregroundColor(.theme.accent)
        }
        .listRowSeparator(.hidden)
    }
    
    var businessSection: some View {
        Section {
            NavigationLink {
                vectorHostDescription
            } label: {
                Text("Векторный хозяин:\n\(vm.hostString(sign: sign.vectorHost))")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
            NavigationLink {
                vectorServantDescription
            } label: {
                Text("Векторный слуга:\n\(vm.servantString(sign: sign.vectorServant))")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
            NavigationLink {
                cloneDescription
            } label: {
                Text("Клоны:\n\(vm.clones(sign: sign))")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
            NavigationLink {
                companionDescription
            } label: {
                Text("Соратники:\n\(vm.companions(sign: sign))")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
            NavigationLink {
                subordinateDescription
            } label: {
                Text("Подчиненные:\n\(vm.subordinates(sign: sign))")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
            NavigationLink {
                adviserDescription
            } label: {
                Text("Советники:\n\(vm.advisers(sign: sign))")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
        } header: {
            Text("Бизнес:")
                .foregroundColor(.theme.accent)
        }
        .listRowSeparator(.hidden)
    }
    
    var marriageSection: some View {
        Section {
            NavigationLink {
                vectorMarriageDescription
            } label: {
                Text("Векторный:\n\(vm.vectorMarriage(sign: sign))")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
            NavigationLink {
                romanticMarriageDescription
            } label: {
                Text("Романтический:\n\(vm.romanticMarriage(sign: sign))")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
            NavigationLink {
                patriarchalMarriageDescription
            } label: {
                Text("Патриархальный:\n\(vm.patriarchalMarriage(sign: sign))")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
            NavigationLink {
                equalMarriageDescription
            } label: {
                Text("Равный:\n\(vm.equalMarriage(sign: sign))")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
            NavigationLink {
                spiritualMarriageDescription
            } label: {
                Text("Духовный:\n\(vm.spiritualMarriage(sign: sign))")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
        } header: {
            Text("Браки:")
                .foregroundColor(.theme.accent)
        }
        .listRowSeparator(.hidden)
    }
    
    var annualSignDescription: some View {
        VStack {
            HStack {
                Button {
                    showAnnualSignDescription.toggle()
                } label: {
                    Label("Назад", systemImage: "chevron.left")
                }
                Spacer()
            }
            .padding()
            ScrollView {
                ForEach(sign.blocks.sorted(by: <), id: \.key) { title, text in
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Spacer()
                            Text(title)
                                .foregroundColor(.theme.standard)
                                .multilineTextAlignment(.center)
                                .font(.headline)
                                .bold()
                            Spacer()
                        }
                        Text(text)
                            .foregroundColor(.theme.secondaryText)
                    }
                    .padding(.bottom, 20)
                }
            }
        }
        .padding()
    }
    
    var maleIdeologicDescription: some View {
        VStack(alignment: .leading) {
            ScrollView {
                HStack {
                    Spacer()
                    Text(sign.ideologicalType[.male]!.title)
                        .foregroundColor(.theme.standard)
                        .font(.headline)
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 15)
                Text(sign.ideologicalType[.male]!.text)
                    .foregroundColor(.theme.secondaryText)
                    .padding(.bottom)
            }
        }
        .padding()
    }
    
    var femaleIdeologicDescription: some View {
        VStack(alignment: .leading) {
            ScrollView {
                HStack {
                    Spacer()
                    Text(sign.ideologicalType[.female]!.title)
                        .foregroundColor(.theme.standard)
                        .font(.headline)
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 15)
                Text(sign.ideologicalType[.female]!.text)
                    .foregroundColor(.theme.secondaryText)
                    .padding(.bottom)
            }
        }
        .padding()
    }
    
    var socialDescription: some View {
        VStack(alignment: .leading) {
            ScrollView {
                HStack {
                    Spacer()
                    Text(sign.socialType.title)
                        .foregroundColor(.theme.standard)
                        .font(.headline)
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 15)
                Text(sign.socialType.text)
                    .foregroundColor(.theme.secondaryText)
                    .padding(.bottom)
            }
        }
        .padding()
    }
    
    var psychologicalDescription: some View {
        VStack(alignment: .leading) {
            ScrollView {
                Spacer()
                HStack {
                    Text(sign.psychologicalType.title)
                        .foregroundColor(.theme.standard)
                        .font(.headline)
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 15)
                Text(sign.psychologicalType.text)
                    .foregroundColor(.theme.secondaryText)
                    .padding(.bottom)
            }
        }
        .padding()
    }
    
    var energyDescription: some View {
        VStack(alignment: .leading) {
            ScrollView {
                HStack {
                    Spacer()
                    Text(sign.temperament.title)
                        .foregroundColor(.theme.standard)
                        .font(.headline)
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 15)
                Text(sign.temperament.text)
                    .foregroundColor(.theme.secondaryText)
                    .padding(.bottom)
            }
        }
        .padding()
    }
    
    var fateDescription: some View {
        VStack(alignment: .leading) {
            ScrollView {
                HStack {
                    Spacer()
                    Text(sign.fateType.title)
                        .foregroundColor(.theme.standard)
                        .font(.headline)
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 15)
                Text(sign.fateType.text)
                    .foregroundColor(.theme.secondaryText)
                    .padding(.bottom)
            }
        }
        .padding()
    }
    
    var vectorHostDescription: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Text(vectorHost.type.rawValue)
                    .foregroundColor(.theme.standard)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            HStack {
                Text(vectorHost.value)
                    .foregroundColor(.theme.secondaryText)
                    .padding(.bottom,15)
                Spacer()
            }
            Text(vectorHost.text)
                .foregroundColor(.theme.secondaryText)
                .padding(.bottom)
            Spacer()
        }
        .padding()
    }
    
    var vectorServantDescription: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Text(vectorServant.type.rawValue)
                    .foregroundColor(.theme.standard)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            HStack {
                Text(vectorServant.value)
                    .foregroundColor(.theme.secondaryText)
                    .padding(.bottom,15)
                Spacer()
            }
            Text(vectorServant.text)
                .foregroundColor(.theme.secondaryText)
                .padding(.bottom)
            Spacer()
        }
        .padding()
    }
    
    var cloneDescription: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Text(clone.type.rawValue)
                    .foregroundColor(.theme.standard)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            HStack {
                Text(clone.value)
                    .foregroundColor(.theme.secondaryText)
                    .padding(.bottom,15)
                Spacer()
            }
            Text(clone.text)
                .foregroundColor(.theme.secondaryText)
                .padding(.bottom)
            Spacer()
        }
        .padding()
    }
    
    var companionDescription: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Text(companion.type.rawValue)
                    .foregroundColor(.theme.standard)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            HStack {
                Text(companion.value)
                    .foregroundColor(.theme.secondaryText)
                    .padding(.bottom,15)
                Spacer()
            }
            Text(companion.text)
                .foregroundColor(.theme.secondaryText)
                .padding(.bottom)
            Spacer()
        }
        .padding()
    }
    
    var subordinateDescription: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Text(subordinate.type.rawValue)
                    .foregroundColor(.theme.standard)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            HStack {
                Text(subordinate.value)
                    .foregroundColor(.theme.secondaryText)
                    .padding(.bottom,15)
                Spacer()
            }
            Text(subordinate.text)
                .foregroundColor(.theme.secondaryText)
                .padding(.bottom)
            Spacer()
        }
        .padding()
    }
    
    var adviserDescription: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Text(adviser.type.rawValue)
                    .foregroundColor(.theme.standard)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            HStack {
                Text(adviser.value)
                    .foregroundColor(.theme.secondaryText)
                    .padding(.bottom,15)
                Spacer()
            }
            Text(adviser.text)
                .foregroundColor(.theme.secondaryText)
                .padding(.bottom)
            Spacer()
        }
        .padding()
    }
    
    var vectorMarriageDescription: some View {
        ScrollView {
            HStack {
                Spacer()
                Text(vectorMarriage.title)
                    .foregroundColor(.theme.standard)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            Text(vectorMarriage.text)
                .foregroundColor(.theme.secondaryText)
                .padding(.bottom)
            Spacer()
        }
        .padding()
    }
    
    var romanticMarriageDescription: some View {
        ScrollView {
            HStack {
                Spacer()
                Text(romanticMarriage.title)
                    .foregroundColor(.theme.standard)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            Text(romanticMarriage.text)
                .foregroundColor(.theme.secondaryText)
                .padding(.bottom)
            Spacer()
        }
        .padding()
    }
    
    var patriarchalMarriageDescription: some View {
        ScrollView {
            HStack {
                Spacer()
                Text(patriarchalMarriage.title)
                    .foregroundColor(.theme.standard)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            Text(patriarchalMarriage.text)
                .foregroundColor(.theme.secondaryText)
                .padding(.bottom)
            Spacer()
        }
        .padding()
    }
    
    var spiritualMarriageDescription: some View {
        ScrollView {
            HStack {
                Spacer()
                Text(spiritualMarriage.title)
                    .foregroundColor(.theme.standard)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            Text(spiritualMarriage.text)
                .foregroundColor(.theme.secondaryText)
                .padding(.bottom)
            Spacer()
        }
        .padding()
    }
    
    var equalMarriageDescription: some View {
        ScrollView {
            HStack {
                Spacer()
                Text(equalMarriage.title)
                    .foregroundColor(.theme.standard)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            Text(equalMarriage.text)
                .foregroundColor(.theme.secondaryText)
                .padding(.bottom)
            Spacer()
        }
        .padding()
    }
}

