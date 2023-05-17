//
//  ContentView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 31.03.2023.
//

import SwiftUI

struct CustomerView: View {
    
    @EnvironmentObject var vm: ViewModel
    @State var customer: ClientStruct
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
                        vm.updateCustomer(client: customer, name: name, sex: sex, birthday: selectedDate, sign: vm.getAnnualSign(date: selectedDate)!, zodiacSign: vm.getZodiacSign(date: selectedDate)!)
                        customer = customer.updateInfo(name: name, sex: sex, birthday: selectedDate, sign: vm.getAnnualSign(date: selectedDate)!, zodiacSign: vm.getZodiacSign(date: selectedDate)!)
                    }
                    isEditing.toggle()
                }
            }
        }
        .sheet(isPresented: $showDescription) {
            annualSignDescription
        }
        .onAppear {
            name = customer.name
            selectedDate = customer.birthday
            sex = customer.sex
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CustomerView(customer: sampleClient)
        }
        .environmentObject(ViewModel())
    }
}

extension CustomerView {
    var customerInfo: some View {
        Section("Личные данные:") {
            Text("🪪 Имя: \(customer.name)")
            Text(customer.sex == .male ? "⚧️ Пол: мужской" : "⚧️ Пол: женский")
            Text("🎂 Дата рождения: \(dateFormatter.string(from: customer.birthday))")
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
                
            } label: {
                Text("💫 Возраст: \(vm.getAgeType(birthdate: selectedDate).rawValue)")
            }
        }
    }
    
    var signSection: some View {
        Section("Знаки:") {
            HStack {
                Image("\(customer.zodiacSign)Small")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                Text("Знак Зодиака: \(customer.zodiacSign.rawValue)")
            }
            HStack {
                Image("\(customer.annualSignStruct.annualSign)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                Text("Годовой знак: \(customer.annualSignStruct.annualSign.rawValue)")
                Spacer()
                Button {
                    showDescription.toggle()
                } label: {
                    Image(systemName: "info.circle")
                }
            }
            NavigationLink {
                VirtualSignView(virtualSign: customer.annualSignStruct.virtualSigns[customer.zodiacSign]!)
            } label: {
                HStack {
                    Text(customer.annualSignStruct.virtualSigns[customer.zodiacSign]!.emoji.rawValue)
                        .fixedSize()
                        .frame(width: 20, height: 20)
                    Text("Виртуальный знак: \(customer.annualSignStruct.virtualSigns[customer.zodiacSign]!.virtualSign.rawValue)")
                }
            }
        }
    }
    
    var typeSection: some View {
        Section("Типы:") {
            NavigationLink {
                IdeologicalView(sign: customer.annualSignStruct.ideologicalType[customer.sex]!)
            } label: {
                Text("Тип мышления: \((customer.annualSignStruct.ideologicalType[customer.sex]!.ideologicalType.rawValue))")
            }
            NavigationLink {
                SocialView(social: customer.annualSignStruct.socialType)
            } label: {
                Text("Социальный тип: \(customer.annualSignStruct.socialType.socialType.rawValue)")
            }
            NavigationLink {
                PsychologicalView(psychologicalStruct: customer.annualSignStruct.psychologicalType)
            } label: {
                Text("Психологический тип: \(customer.annualSignStruct.psychologicalType.psychologicalType.rawValue)")
            }
            NavigationLink {
                EnergyView(energy: customer.annualSignStruct.temperament)
            } label: {
                Text("Энергетический тип:\n\(customer.annualSignStruct.temperament.energyType.rawValue)")
            }
            NavigationLink {
                FateView(fate: customer.annualSignStruct.fateType)
            } label: {
                Text("Тип судьбы: \(customer.annualSignStruct.fateType.fateType.rawValue)")
            }
        }
    }
    
    var businessSection: some View {
        Section("Бизнес:") {
            NavigationLink {
                BusinessView(business: vectorHost, sign: customer.annualSignStruct.annualSign)
            } label: {
                Text("Векторный хозяин:\n\(vm.hostString(sign: customer.annualSignStruct.vectorHost))")
                    .lineSpacing(6)
            }
            NavigationLink {
                BusinessView(business: vectorServant, sign: customer.annualSignStruct.annualSign)
            } label: {
                Text("Векторный слуга:\n\(vm.servantString(sign: customer.annualSignStruct.vectorServant))")
                    .lineSpacing(6)
            }
            NavigationLink {
                BusinessView(business: clone, sign: customer.annualSignStruct.annualSign)
            } label: {
                Text("Клоны:\n\(vm.clones(sign: customer.annualSignStruct))")
                    .lineSpacing(6)
            }
            NavigationLink {
                BusinessView(business: companion, sign: customer.annualSignStruct.annualSign)
            } label: {
                Text("Соратники:\n\(vm.companions(sign: customer.annualSignStruct))")
                    .lineSpacing(6)
            }
            NavigationLink {
                BusinessView(business: subordinate, sign: customer.annualSignStruct.annualSign)
            } label: {
                Text("Подчиненные:\n\(vm.subordinates(sign: customer.annualSignStruct))")
                    .lineSpacing(6)
            }
            NavigationLink {
                BusinessView(business: subordinate, sign: customer.annualSignStruct.annualSign)
            } label: {
                Text("Советники:\n\(vm.advisers(sign: customer.annualSignStruct))")
                    .lineSpacing(6)
            }
        }
    }
    
    var marriageSection: some View {
        Section("Брак:") {
            NavigationLink {
                MarriageView(marriage: vectorMarriage, sign: customer.annualSignStruct.annualSign)
            } label: {
                Text("Векторный:\n\(vm.vectorMarriage(sign: customer.annualSignStruct))")
                    .lineSpacing(6)
            }
            NavigationLink {
                MarriageView(marriage: romanticMarriage, sign: customer.annualSignStruct.annualSign)
            } label: {
                Text("Романтический:\n\(vm.romanticMarriage(sign: customer.annualSignStruct))")
                    .lineSpacing(6)
            }
            NavigationLink {
                MarriageView(marriage: patriarchalMarriage, sign: customer.annualSignStruct.annualSign)
            } label: {
                Text("Патриархальный:\n\(vm.patriarchalMarriage(sign: customer.annualSignStruct))")
                    .lineSpacing(6)
            }
            NavigationLink {
                MarriageView(marriage: spiritualMarriage, sign: customer.annualSignStruct.annualSign)
            } label: {
                Text("Духовный:\n\(vm.spiritualMarriage(sign: customer.annualSignStruct))")
                    .lineSpacing(6)
            }
            NavigationLink {
                MarriageView(marriage: equalMarriage, sign: customer.annualSignStruct.annualSign)
            } label: {
                Text("Равный:\n\(vm.equalMarriage(sign: customer.annualSignStruct))")
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
            ScrollView {
                ForEach(customer.annualSignStruct.blocks.sorted(by: <), id: \.key) { title, text in
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
