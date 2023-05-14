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
    @State private var selectedDate = Date()
//    @State private var annualSign = AnnualEnum.cat
//    @State private var zodiacSign = ZodiacEnum.aquarius
    @State private var theme = ThemeEnum.light
    @State private var notifications = true
    @State private var sync = true
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack(spacing: 20) {
                        Text("Имя")
                        TextField("Напишите ваше имя", text: $name)
                            .textFieldStyle(.roundedBorder)
                    }
                    HStack(spacing: 20) {
                        Text("Пол")
                        Picker(selection: $sex) {
                            ForEach(Sex.allCases, id: \.self) { sign in
                                Text(sign == .male ? "Мужской" : "Женский").tag(sign)
                            }
                        } label: {
                            Text("Picker")
                        }
                        .pickerStyle(.segmented)
                    }
                    DatePicker("Дата рождения:", selection: $selectedDate, displayedComponents: .date)
                }
                Section {
                    Picker(selection: $theme) {
                        ForEach(ThemeEnum.allCases, id: \.self) { theme in
                            Text(theme.rawValue)
                        }
                    } label: {
                        Text("Тема")
                    }
                    .pickerStyle(.menu)
                    Toggle("Уведомления", isOn: $notifications)
                    Toggle("Синхронизация iCloud", isOn: $sync)
                }
            }
            .onAppear {
                name = vm.mainUser.name
                sex = vm.mainUser.sex
                selectedDate = vm.mainUser.birthday
//                annualSign = vm.mainUser.annualSignStruct.annualSign
//                zodiacSign = vm.mainUser.zodiacSign
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
