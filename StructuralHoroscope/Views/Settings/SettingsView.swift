//
//  SettingsView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 27.04.2023.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject private var vm: ViewModel
    @State private var name = ""
    @State private var sex = Sex.male
    
    var body: some View {
        NavigationStack {
            List {
                VStack(alignment: .leading) {
                    Text("Имя")
                    TextField("Напишите ваше имя", text: $name)
                        .textFieldStyle(.roundedBorder)
                    VStack(alignment: .leading) {
                        Text("Пол")
                        Picker(selection: $sex) {
                            ForEach(Sex.allCases, id: \.self) { sign in
                                Text(sign == .male ? "Мужчина" : "Женщина").tag(sign)
                            }
                        } label: {
                            Text("Picker")
                        }
                        .pickerStyle(.segmented)
                    }
                }
            }
            .navigationTitle("Настройки")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingsView()
        }
        .environmentObject(ViewModel())
    }
}
