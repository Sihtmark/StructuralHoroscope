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
    @State private var showDescription = false

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
            } else {
                customerInfo
            }
            signSection
            typeSection
            businessSection
            marriageSection
        }
        .navigationTitle("Структура знака")
        .navigationBarTitleDisplayMode(.inline)
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
        .sheet(isPresented: $showDescription) {
            annualSignDescription
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
        Section("Личные данные:") {
            Text("🪪 Имя: \(vm.mainUser.name)")
            Text(vm.mainUser.sex == .male ? "⚧️ Пол: мужской" : "⚧️ Пол: женский")
            Text("🎂 Дата рождения: \(dateFormatter.string(from: vm.mainUser.birthday))")
            NavigationLink {
                AgeView(age: ages[vm.getAgeType(birthdate: selectedDate)]!)
            } label: {
                Text("💫 Возраст: \(vm.getAgeType(birthdate: selectedDate).rawValue)")
            }
        }
    }
    
    var editCustomerInfo: some View {
        Section {
            HStack {
                Text("🪪 Имя:")
                TextField("Введите новое имя", text: $name)
                    .textFieldStyle(.roundedBorder)
            }
            HStack(spacing: 30) {
                Text("⚧️ Пол:")
                Picker(selection: $sex) {
                    Text("Мужской").tag(Sex.male)
                    Text("Женский").tag(Sex.female)
                } label: {
                    Text("asdf")
                }
                .pickerStyle(.segmented)
            }
            DatePicker("🎂 Дата рождения:", selection: $selectedDate, displayedComponents: .date)
                .environment(\.locale, Locale.init(identifier: "ru"))
            NavigationLink {
                AgeView(age: ages[vm.getAgeType(birthdate: selectedDate)]!)
            } label: {
                Text("💫 Возраст: \(vm.getAgeType(birthdate: selectedDate).rawValue)")
            }
        }
    }
    
    var signSection: some View {
        Section("Знаки:") {
            HStack {
                Image("\(vm.mainUser.zodiacSign)Small")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                Text("Знак Зодиака: \(vm.mainUser.zodiacSign.rawValue)")
            }
            HStack {
                Image("\(vm.mainUser.annualSignStruct.annualSign)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                Text("Годовой знак: \(vm.mainUser.annualSignStruct.annualSign.rawValue)")
                Spacer()
                Button {
                    showDescription.toggle()
                } label: {
                    Image(systemName: "info.circle")
                }
            }
            NavigationLink {
                VirtualSignView(virtualSign: vm.mainUser.annualSignStruct.virtualSigns[vm.mainUser.zodiacSign]!)
            } label: {
                HStack {
                    Text(vm.mainUser.annualSignStruct.virtualSigns[vm.mainUser.zodiacSign]!.emoji.rawValue)
                        .fixedSize()
                        .frame(width: 20, height: 20)
                    Text("Виртуальный знак: \(vm.mainUser.annualSignStruct.virtualSigns[vm.mainUser.zodiacSign]!.virtualSign.rawValue)")
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
                Text("Энергетический тип:\n\(vm.mainUser.annualSignStruct.temperament.energyType.rawValue)")
            }
            NavigationLink {
                FateView(fate: vm.mainUser.annualSignStruct.fateType)
            } label: {
                Text("Тип судьбы: \(vm.mainUser.annualSignStruct.fateType.fateType.rawValue)")
            }
        }
    }
    var businessSection: some View {
        Section("Бизнес:") {
            NavigationLink {
                BusinessView(business: vectorHost, sign: vm.mainUser.annualSignStruct.annualSign)
            } label: {
                Text("Векторный хозяин:\n\(vm.hostString(sign: vm.mainUser.annualSignStruct.vectorHost))")
                    .lineSpacing(6)
            }
            NavigationLink {
                BusinessView(business: vectorServant, sign: vm.mainUser.annualSignStruct.annualSign)
            } label: {
                Text("Векторный слуга:\n\(vm.servantString(sign: vm.mainUser.annualSignStruct.vectorServant))")
                    .lineSpacing(6)
            }
            NavigationLink {
                BusinessView(business: clone, sign: vm.mainUser.annualSignStruct.annualSign)
            } label: {
                Text("Клоны:\n\(vm.clones(sign: vm.mainUser.annualSignStruct))")
                    .lineSpacing(6)
            }
            NavigationLink {
                BusinessView(business: companion, sign: vm.mainUser.annualSignStruct.annualSign)
            } label: {
                Text("Соратники:\n\(vm.companions(sign: vm.mainUser.annualSignStruct))")
                    .lineSpacing(6)
            }
            NavigationLink {
                BusinessView(business: subordinate, sign: vm.mainUser.annualSignStruct.annualSign)
            } label: {
                Text("Подчиненные:\n\(vm.subordinates(sign: vm.mainUser.annualSignStruct))")
                    .lineSpacing(6)
            }
            NavigationLink {
                BusinessView(business: subordinate, sign: vm.mainUser.annualSignStruct.annualSign)
            } label: {
                Text("Советники:\n\(vm.advisers(sign: vm.mainUser.annualSignStruct))")
                    .lineSpacing(6)
            }
        }
    }
    var marriageSection: some View {
        Section("Брак:") {
            NavigationLink {
                MarriageView(marriage: vectorMarriage, sign: vm.mainUser.annualSignStruct.annualSign)
            } label: {
                Text("Векторный брак:\n\(vm.vectorMarriage(sign: vm.mainUser.annualSignStruct))")
                    .lineSpacing(6)
            }
            NavigationLink {
                MarriageView(marriage: romanticMarriage, sign: vm.mainUser.annualSignStruct.annualSign)
            } label: {
                Text("Романтический брак:\n\(vm.romanticMarriage(sign: vm.mainUser.annualSignStruct))")
                    .lineSpacing(6)
            }
            NavigationLink {
                MarriageView(marriage: patriarchalMarriage, sign: vm.mainUser.annualSignStruct.annualSign)
            } label: {
                Text("Патриархальный брак:\n\(vm.patriarchalMarriage(sign: vm.mainUser.annualSignStruct))")
                    .lineSpacing(6)
            }
            NavigationLink {
                MarriageView(marriage: spiritualMarriage, sign: vm.mainUser.annualSignStruct.annualSign)
            } label: {
                Text("Духовный брак:\n\(vm.spiritualMarriage(sign: vm.mainUser.annualSignStruct))")
                    .lineSpacing(6)
            }
            NavigationLink {
                MarriageView(marriage: equalMarriage, sign: vm.mainUser.annualSignStruct.annualSign)
            } label: {
                Text("Равный брак:\n\(vm.equalMarriage(sign: vm.mainUser.annualSignStruct))")
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
                ForEach(vm.mainUser.annualSignStruct.blocks.sorted(by: <), id: \.key) { title, text in
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
