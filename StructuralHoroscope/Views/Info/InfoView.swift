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
                Section {
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
                Section {
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
                } header: {
                    Text("Годовые структуры")
                        .foregroundColor(.black)
                }
                Section {
                    NavigationLink {
                        SensualityStructView()
                    } label: {
                        Text("Структура чувственности")
                    }
                    NavigationLink {
                        
                    } label: {
                        Text("Структура стихий")
                    }
                    NavigationLink {
                        
                    } label: {
                        Text("Малое векторное кольцо")
                    }
                } header: {
                    Text("Зодиакальные структуры")
                        .foregroundColor(.black)
                }
                Section {
                    NavigationLink {
                        
                    } label: {
                        Text("Служебный гороскоп")
                    }
                    NavigationLink {
                        
                    } label: {
                        Text("Типы браков")
                    }
                    NavigationLink {
                        
                    } label: {
                        Text("Возрасты")
                    }
                }
            }
            .navigationTitle("Структуры")
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
