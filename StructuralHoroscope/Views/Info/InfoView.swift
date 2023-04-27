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
                        
                    } label: {
                        Text("Виртуальные знаки")
                    }
                    NavigationLink {
                        
                    } label: {
                        Text("Годовые знаки")
                    }
                    NavigationLink {
                        
                    } label: {
                        Text("Служебный гороскоп")
                    }
                }
                Section {
                    NavigationLink {
                        
                    } label: {
                        Text("Векторное кольцо")
                    }
                    NavigationLink {
                        
                    } label: {
                        Text("Идеологическая структура")
                    }
                    NavigationLink {
                        
                    } label: {
                        Text("Социальная структура")
                    }
                    NavigationLink {
                        
                    } label: {
                        Text("Психологическая структура")
                    }
                    NavigationLink {
                        
                    } label: {
                        Text("Энергетическая структура")
                    }
                    NavigationLink {
                        
                    } label: {
                        Text("Структура судьбы")
                    }
                } header: {
                    Text("Годовые структуры")
                        .foregroundColor(.black)
                }
                Section {
                    NavigationLink {
                        
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
