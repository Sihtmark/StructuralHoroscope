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
        }
        .environmentObject(ViewModel())
    }
}

extension AnnualSignView {
    
    var typeSection: some View {
        Section("Структура:") {
            NavigationLink {
                maleIdeologicDescription
            } label: {
                Text("🕺 \(sign.ideologicalType[Sex.male]!.ideologicalType.rawValue)")
            }
            NavigationLink {
                femaleIdeologicDescription
            } label: {
                Text("💃 \(sign.ideologicalType[Sex.female]!.ideologicalType.rawValue)")
            }
            NavigationLink {
                socialDescription
            } label: {
                Text("Социальный тип:\n\(sign.socialType.socialType.rawValue)")
                    .lineSpacing(6)
            }
            NavigationLink {
                psychologicalDescription
            } label: {
                Text("Психологический тип:\n\(sign.psychologicalType.psychologicalType.rawValue)")
                    .lineSpacing(6)
            }
            NavigationLink {
                energyDescription
            } label: {
                Text("Энергетический тип:\n\(sign.temperament.energyType.rawValue)")
                    .lineSpacing(6)
            }
            NavigationLink {
                fateDescription
            } label: {
                Text("Тип судьбы:\n\(sign.fateType.fateType.rawValue)")
                    .lineSpacing(6)
            }
            
        }
    }
    
    var businessSection: some View {
        Section("Бизнес:") {
            NavigationLink {
                vectorHostDescription
            } label: {
                Text("Векторный хозяин:\n\(vm.hostString(sign: sign.vectorHost))")
                    .lineSpacing(6)
            }
            NavigationLink {
                vectorServantDescription
            } label: {
                Text("Векторный слуга:\n\(vm.servantString(sign: sign.vectorServant))")
                    .lineSpacing(6)
            }
            NavigationLink {
                cloneDescription
            } label: {
                Text("Клоны:\n\(vm.clones(sign: sign))")
                    .lineSpacing(6)
            }
            NavigationLink {
                companionDescription
            } label: {
                Text("Соратники:\n\(vm.companions(sign: sign))")
                    .lineSpacing(6)
            }
            NavigationLink {
                subordinateDescription
            } label: {
                Text("Подчиненные:\n\(vm.subordinates(sign: sign))")
                    .lineSpacing(6)
            }
            NavigationLink {
                adviserDescription
            } label: {
                Text("Советники:\n\(vm.advisers(sign: sign))")
                    .lineSpacing(6)
            }
        }
    }
    
    var marriageSection: some View {
        Section("Браки:") {
            NavigationLink {
                vectorMarriageDescription
            } label: {
                Text("Векторный:\n\(vm.vectorMarriage(sign: sign))")
                    .lineSpacing(6)
            }
            NavigationLink {
                romanticMarriageDescription
            } label: {
                Text("Романтический:\n\(vm.romanticMarriage(sign: sign))")
                    .lineSpacing(6)
            }
            NavigationLink {
                patriarchalMarriageDescription
            } label: {
                Text("Патриархальный:\n\(vm.patriarchalMarriage(sign: sign))")
                    .lineSpacing(6)
            }
            NavigationLink {
                equalMarriageDescription
            } label: {
                Text("Равный:\n\(vm.equalMarriage(sign: sign))")
                    .lineSpacing(6)
            }
            NavigationLink {
                spiritualMarriageDescription
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
                        Text(title)
                            .font(.headline)
                            .bold()
                        Text(text)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .padding()
    }
    
    var maleIdeologicDescription: some View {
        VStack(alignment: .leading) {
            ScrollView {
                HStack {
                    Text(sign.ideologicalType[.male]!.title)
                        .font(.headline)
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 15)
                Text(sign.ideologicalType[.male]!.text)
                    .foregroundColor(.secondary)
                    .padding(.bottom)
            }
        }
        .padding()
    }
    
    var femaleIdeologicDescription: some View {
        VStack(alignment: .leading) {
            ScrollView {
                HStack {
                    Text(sign.ideologicalType[.female]!.title)
                        .font(.headline)
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 15)
                Text(sign.ideologicalType[.female]!.text)
                    .foregroundColor(.secondary)
                    .padding(.bottom)
            }
        }
        .padding()
    }
    
    var socialDescription: some View {
        VStack(alignment: .leading) {
            ScrollView {
                HStack {
                    Text(sign.socialType.title)
                        .font(.headline)
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 15)
                Text(sign.socialType.text)
                    .foregroundColor(.secondary)
                    .padding(.bottom)
            }
        }
        .padding()
    }
    
    var psychologicalDescription: some View {
        VStack(alignment: .leading) {
            ScrollView {
                HStack {
                    Text(sign.psychologicalType.title)
                        .font(.headline)
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 15)
                Text(sign.psychologicalType.text)
                    .foregroundColor(.secondary)
                    .padding(.bottom)
            }
        }
        .padding()
    }
    
    var energyDescription: some View {
        VStack(alignment: .leading) {
            ScrollView {
                HStack {
                    Text(sign.temperament.title)
                        .font(.headline)
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 15)
                Text(sign.temperament.text)
                    .foregroundColor(.secondary)
                    .padding(.bottom)
            }
        }
        .padding()
    }
    
    var fateDescription: some View {
        VStack(alignment: .leading) {
            ScrollView {
                HStack {
                    Text(sign.fateType.title)
                        .font(.headline)
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 15)
                Text(sign.fateType.text)
                    .foregroundColor(.secondary)
                    .padding(.bottom)
            }
        }
        .padding()
    }
    
    var vectorHostDescription: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(vectorHost.type.rawValue)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            HStack {
                Text(vectorHost.value)
                    .padding(.bottom,15)
                Spacer()
            }
            Text(vectorHost.text)
                .foregroundColor(.secondary)
                .padding(.bottom)
            Spacer()
        }
        .padding()
    }
    
    var vectorServantDescription: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(vectorServant.type.rawValue)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            HStack {
                Text(vectorServant.value)
                    .padding(.bottom,15)
                Spacer()
            }
            Text(vectorServant.text)
                .foregroundColor(.secondary)
                .padding(.bottom)
            Spacer()
        }
        .padding()
    }
    
    var cloneDescription: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(clone.type.rawValue)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            HStack {
                Text(clone.value)
                    .padding(.bottom,15)
                Spacer()
            }
            Text(clone.text)
                .foregroundColor(.secondary)
                .padding(.bottom)
            Spacer()
        }
        .padding()
    }
    
    var companionDescription: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(companion.type.rawValue)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            HStack {
                Text(companion.value)
                    .padding(.bottom,15)
                Spacer()
            }
            Text(companion.text)
                .foregroundColor(.secondary)
                .padding(.bottom)
            Spacer()
        }
        .padding()
    }
    
    var subordinateDescription: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(subordinate.type.rawValue)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            HStack {
                Text(subordinate.value)
                    .padding(.bottom,15)
                Spacer()
            }
            Text(subordinate.text)
                .foregroundColor(.secondary)
                .padding(.bottom)
            Spacer()
        }
        .padding()
    }
    
    var adviserDescription: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(adviser.type.rawValue)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            HStack {
                Text(adviser.value)
                    .padding(.bottom,15)
                Spacer()
            }
            Text(adviser.text)
                .foregroundColor(.secondary)
                .padding(.bottom)
            Spacer()
        }
        .padding()
    }
    
    var vectorMarriageDescription: some View {
        ScrollView {
            HStack {
                Text(vectorMarriage.title)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            Text(vectorMarriage.text)
                .foregroundColor(.secondary)
                .padding(.bottom)
            Spacer()
        }
        .padding()
    }
    
    var romanticMarriageDescription: some View {
        ScrollView {
            HStack {
                Text(romanticMarriage.title)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            Text(romanticMarriage.text)
                .foregroundColor(.secondary)
                .padding(.bottom)
            Spacer()
        }
        .padding()
    }
    
    var patriarchalMarriageDescription: some View {
        ScrollView {
            HStack {
                Text(patriarchalMarriage.title)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            Text(patriarchalMarriage.text)
                .foregroundColor(.secondary)
                .padding(.bottom)
            Spacer()
        }
        .padding()
    }
    
    var spiritualMarriageDescription: some View {
        ScrollView {
            HStack {
                Text(spiritualMarriage.title)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            Text(spiritualMarriage.text)
                .foregroundColor(.secondary)
                .padding(.bottom)
            Spacer()
        }
        .padding()
    }
    
    var equalMarriageDescription: some View {
        ScrollView {
            HStack {
                Text(equalMarriage.title)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            Text(equalMarriage.text)
                .foregroundColor(.secondary)
                .padding(.bottom)
            Spacer()
        }
        .padding()
    }
}

