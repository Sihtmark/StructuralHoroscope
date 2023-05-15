//
//  MainCustomerView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 15.05.2023.
//

import SwiftUI

struct MainCustomerView: View {
    
    @EnvironmentObject var vm: ViewModel
    @State private var isEditing = false

    @State private var name = ""
    @State private var selectedDate = Date()
    @State private var sex: Sex = .male
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }
    
    var body: some View {
        List {
            if isEditing {
                editCustomerInfo
                signSection
                typeSection
                vectorSection
                businessSection
                marriageSection
            } else {
                customerInfo
                signSection
                typeSection
                vectorSection
                businessSection
                marriageSection
            }
        }
        .navigationTitle(vm.mainUser.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(isEditing ? "Сохранить" : "Изменить") {
                    if isEditing {
                        vm.updateMainUser(name: name, sex: sex, birthday: selectedDate, sign: vm.getAnnualSign(date: selectedDate)!, zodiacSign: vm.getZodiacSign(date: selectedDate)!)
                    }
                    isEditing.toggle()
                }
            }
        }
        .onAppear {
            name = vm.mainUser.name
            selectedDate = vm.mainUser.birthday
            sex = vm.mainUser.sex
        }
    }
}

struct MainCustomerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MainCustomerView()
        }
        .environmentObject(ViewModel())
    }
}

extension MainCustomerView {
    var customerInfo: some View {
        Section {
            Text(vm.mainUser.name)
            Text(vm.mainUser.sex == .male ? "Пол: мужской" : "Пол: женский")
            Text("День рождения: \(dateFormatter.string(from: vm.mainUser.birthday))")
        }
    }
    
    var editCustomerInfo: some View {
        Section {
            TextField("Введите новое имя", text: $name)
                .textFieldStyle(.roundedBorder)
            HStack(spacing: 30) {
                Text("Пол")
                Picker(selection: $sex) {
                    Text("Мужской").tag(Sex.male)
                    Text("Женский").tag(Sex.female)
                } label: {
                    Text("Picker")
                }
                .pickerStyle(.segmented)
            }
            DatePicker("День рождения:", selection: $selectedDate, displayedComponents: .date)
                .environment(\.locale, Locale.init(identifier: "ru"))
        }
    }
    
    var signSection: some View {
        Section("Знаки:") {
            Text("Знак Зодиака: \(vm.mainUser.zodiacSign.rawValue)")
            NavigationLink {
                AnnualSignView(sign: vm.mainUser.annualSignStruct)
            } label: {
                HStack {
                    Text("Годовой знак: \(vm.mainUser.annualSignStruct.annualSign.rawValue)")
                }
            }
            NavigationLink {
                VirtualSignView(virtualSign: vm.mainUser.annualSignStruct.virtualSigns[vm.mainUser.zodiacSign]!)
            } label: {
                HStack {
                    Text("Виртуальный знак: \(vm.mainUser.annualSignStruct.virtualSigns[vm.mainUser.zodiacSign]!.virtualSign)")
                }
            }
        }
    }
    
    var typeSection: some View {
        Section("Типы:") {
            NavigationLink {
                IdeologicalView(sign: vm.mainUser.annualSignStruct.ideologicalType[vm.mainUser.sex]!)
            } label: {
                Text("Тип мышления: \((vm.mainUser.annualSignStruct.ideologicalType[vm.mainUser.sex]!.ideologicalType.rawValue))")
            }
            NavigationLink {
                SocialView(social: vm.mainUser.annualSignStruct.socialType)
            } label: {
                Text("Социальный тип: \(vm.mainUser.annualSignStruct.socialType.socialType.rawValue)")
            }
            NavigationLink {
                PsychologicalView(psychologicalStruct: vm.mainUser.annualSignStruct.psychologicalType)
            } label: {
                Text("Психологический тип: \(vm.mainUser.annualSignStruct.psychologicalType.psychologicalType.rawValue)")
            }
            NavigationLink {
                EnergyView(energy: vm.mainUser.annualSignStruct.temperament)
            } label: {
                Text("Энергетический тип: \(vm.mainUser.annualSignStruct.temperament.energyType.rawValue)")
            }
            NavigationLink {
                FateView(fate: vm.mainUser.annualSignStruct.fateType)
            } label: {
                Text("Тип судьбы: \(vm.mainUser.annualSignStruct.fateType.fateType.rawValue)")
            }
        }
    }
    var vectorSection: some View {
        Section("Векторы:") {
            NavigationLink {
                AnnualSignView(sign: annualSigns[vm.mainUser.annualSignStruct.vectorHost]!)
            } label: {
                Text("Хозяин: \(vm.mainUser.annualSignStruct.vectorHost.rawValue)")
            }
            NavigationLink {
                AnnualSignView(sign: annualSigns[vm.mainUser.annualSignStruct.vectorServant]!)
            } label: {
                Text("Слуга: \(vm.mainUser.annualSignStruct.vectorServant.rawValue)")
            }
        }
    }
    var businessSection: some View {
        Section("Бизнес:") {
            NavigationLink {
                BusinessView(business: vectorHost, sign: vm.mainUser.annualSignStruct.annualSign)
            } label: {
                Text("Векторный хозяин: \(vm.mainUser.annualSignStruct.vectorHost.rawValue)")
            }
            NavigationLink {
                BusinessView(business: vectorServant, sign: vm.mainUser.annualSignStruct.annualSign)
            } label: {
                Text("Векторный слуга: \(vm.mainUser.annualSignStruct.vectorServant.rawValue)")
            }
            NavigationLink {
                BusinessView(business: clone, sign: vm.mainUser.annualSignStruct.annualSign)
            } label: {
                Text("Клоны: \(vm.clones(sign: vm.mainUser.annualSignStruct))")
            }
            NavigationLink {
                BusinessView(business: companion, sign: vm.mainUser.annualSignStruct.annualSign)
            } label: {
                Text("Соратники: \(vm.companions(sign: vm.mainUser.annualSignStruct))")
            }
            NavigationLink {
                BusinessView(business: subordinate, sign: vm.mainUser.annualSignStruct.annualSign)
            } label: {
                Text("Подчиненные: \(vm.subordinates(sign: vm.mainUser.annualSignStruct))")
            }
            NavigationLink {
                BusinessView(business: subordinate, sign: vm.mainUser.annualSignStruct.annualSign)
            } label: {
                Text("Советники: \(vm.advisers(sign: vm.mainUser.annualSignStruct))")
            }
        }
    }
    var marriageSection: some View {
        Section("Браки:") {
            NavigationLink {
                MarriageView(marriage: vectorMarriage, sign: vm.mainUser.annualSignStruct.annualSign)
            } label: {
                Text("Векторный брак: \(vm.vectorMarriage(sign: vm.mainUser.annualSignStruct))")
            }
            NavigationLink {
                MarriageView(marriage: romanticMarriage, sign: vm.mainUser.annualSignStruct.annualSign)
            } label: {
                Text("Романтический брак: \(vm.romanticMarriage(sign: vm.mainUser.annualSignStruct))")
            }
            NavigationLink {
                MarriageView(marriage: patriarchalMarriage, sign: vm.mainUser.annualSignStruct.annualSign)
            } label: {
                Text("Патриархальный брак: \(vm.patriarchalMarriage(sign: vm.mainUser.annualSignStruct))")
            }
            NavigationLink {
                MarriageView(marriage: spiritualMarriage, sign: vm.mainUser.annualSignStruct.annualSign)
            } label: {
                Text("Духовный брак: \(vm.spiritualMarriage(sign: vm.mainUser.annualSignStruct))")
            }
            NavigationLink {
                MarriageView(marriage: equalMarriage, sign: vm.mainUser.annualSignStruct.annualSign)
            } label: {
                Text("Равный брак: \(vm.equalMarriage(sign: vm.mainUser.annualSignStruct))")
            }
        }
    }
}
