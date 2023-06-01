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
                assistantSection
                annualStructureSection
            }
            .scrollIndicators(ScrollIndicatorVisibility.hidden)
            .frame(maxWidth: 550)
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
                .preferredColorScheme(.dark)
        }
        .environmentObject(ViewModel())
        NavigationStack {
            InfoView()
                .preferredColorScheme(.light)
        }
        .environmentObject(ViewModel())
    }
}

extension InfoView {
    var mainView: some View {
        Section {
            NavigationLink {
                AnnualSignsView()
            } label: {
                Text("Годовые знаки")
                    .foregroundColor(.theme.standard)
            }
            NavigationLink {
                SocialSignsView()
            } label: {
                Text("Виртуальные знаки")
                    .foregroundColor(.theme.standard)
            }
        } header: {
            Text("Знаки")
                .foregroundColor(.theme.accent)
        }
        .listRowSeparator(.hidden)
    }
    var annualStructureSection: some View {
        Section {
            NavigationLink {
                VectorPareView()
            } label: {
                Text("Векторные пары")
                    .foregroundColor(.theme.standard)
            }
            NavigationLink {
                IdeologicalStructView()
            } label: {
                Text("Идеологическая структура")
                    .foregroundColor(.theme.standard)
            }
            NavigationLink {
                SocialStructView()
            } label: {
                Text("Социальная структура")
                    .foregroundColor(.theme.standard)
            }
            NavigationLink {
                PsychologicalStructView()
            } label: {
                Text("Психологическая структура")
                    .foregroundColor(.theme.standard)
            }
            NavigationLink {
                EnergyStructView()
            } label: {
                Text("Энергетическая структура")
                    .foregroundColor(.theme.standard)
            }
            NavigationLink {
                FateStructView()
            } label: {
                Text("Структура судьбы")
                    .foregroundColor(.theme.standard)
            }
        } header: {
            Text("Cтруктуры")
                .foregroundColor(.theme.accent)
        }
        .listRowSeparator(.hidden)
    }
    var assistantSection: some View {
        Section {
            NavigationLink {
                AgeStructView()
            } label: {
                Text("Возраст")
                    .foregroundColor(.theme.standard)
            }
            NavigationLink {
                BusinessStructview()
            } label: {
                Text("Бизнес")
                    .foregroundColor(.theme.standard)
            }
            NavigationLink {
                MarriageStructView()
            } label: {
                Text("Брак")
                    .foregroundColor(.theme.standard)
            }
        } header: {
            Text("Отношения")
                .foregroundColor(.theme.accent)
        }
        .listRowSeparator(.hidden)
    }
}
