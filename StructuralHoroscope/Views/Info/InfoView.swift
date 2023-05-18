//
//  InfoView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 27.04.2023.
//

import SwiftUI

struct InfoView: View {
    
    @EnvironmentObject private var vm: ViewModel
    
    var body: some View {
        NavigationStack {
            List {
                mainView
                annualStructureSection
                zodiacStructureSection
                assistantSection
            }
            .listStyle(.inset)
            .navigationTitle("Информация")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            InfoView()
        }
        .environmentObject(ViewModel())
    }
}

extension InfoView {
    var mainView: some View {
        Section("Знаки") {
            NavigationLink {
                AnnualSignsView()
            } label: {
                Text("Годовые знаки")
            }
            NavigationLink {
                VirtualSignsView()
            } label: {
                Text("Виртуальные знаки")
            }
        }
    }
    var annualStructureSection: some View {
        Section("Годовые структуры") {
            NavigationLink {
                VectorRingView()
            } label: {
                Text("Векторное кольцо")
            }
            NavigationLink {
                IdeologicalStructView()
            } label: {
                Text("Идеологическая структура")
            }
            NavigationLink {
                SocialStructView()
            } label: {
                Text("Социальная структура")
            }
            NavigationLink {
                PsychologicalStructView()
            } label: {
                Text("Психологическая структура")
            }
            NavigationLink {
                EnergyStructView()
            } label: {
                Text("Энергетическая структура")
            }
            NavigationLink {
                FateStructView()
            } label: {
                Text("Структура судьбы")
            }
        }
    }
    var zodiacStructureSection: some View {
        Section("Зодиакальные структуры") {
            NavigationLink {
                SensualityStructView()
            } label: {
                Text("Структура чувственности")
            }
            NavigationLink {
                ElementStructView()
            } label: {
                Text("Структура стихий")
            }
            NavigationLink {
                SmallVectorRingView()
            } label: {
                Text("Малое векторное кольцо")
            }
        }
    }
    var assistantSection: some View {
        Section("") {
            NavigationLink {
                BusinessStructview()
            } label: {
                Text("Бизнес")
            }
            NavigationLink {
                MarriageStructView()
            } label: {
                Text("Брак")
            }
            NavigationLink {
                AgeStructView()
            } label: {
                Text("Возраст")
            }
        }
    }
}
