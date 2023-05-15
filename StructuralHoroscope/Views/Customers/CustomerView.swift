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
        .navigationTitle(customer.name)
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
            NavigationLink {
                AnnualSignView(sign: customer.annualSignStruct)
            } label: {
                HStack {
                    Image("\(customer.annualSignStruct.annualSign)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    Text("Годовой знак: \(customer.annualSignStruct.annualSign.rawValue)")
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
    var vectorSection: some View {
        Section("Осторожно!") {
            NavigationLink {
                AnnualSignView(sign: annualSigns[customer.annualSignStruct.vectorHost]!)
            } label: {
                HStack {
                    Image("\(customer.annualSignStruct.vectorHost)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    Text("Хозяин: \(customer.annualSignStruct.vectorHost.rawValue)")
                }
            }
            NavigationLink {
                AnnualSignView(sign: annualSigns[customer.annualSignStruct.vectorServant]!)
            } label: {
                HStack {
                    Image("\(customer.annualSignStruct.vectorServant)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    Text("Слуга: \(customer.annualSignStruct.vectorServant.rawValue)")
                }
            }
        }
    }
    var businessSection: some View {
        Section("Бизнес:") {
            NavigationLink {
                BusinessView(business: vectorHost, sign: customer.annualSignStruct.annualSign)
            } label: {
                Text("Векторный хозяин: \(customer.annualSignStruct.vectorHost.rawValue)")
            }
            NavigationLink {
                BusinessView(business: vectorServant, sign: customer.annualSignStruct.annualSign)
            } label: {
                Text("Векторный слуга: \(customer.annualSignStruct.vectorServant.rawValue)")
            }
            NavigationLink {
                BusinessView(business: clone, sign: customer.annualSignStruct.annualSign)
            } label: {
                Text("Клоны:\n\(vm.clones(sign: customer.annualSignStruct))")
            }
            NavigationLink {
                BusinessView(business: companion, sign: customer.annualSignStruct.annualSign)
            } label: {
                Text("Соратники:\n\(vm.companions(sign: customer.annualSignStruct))")
            }
            NavigationLink {
                BusinessView(business: subordinate, sign: customer.annualSignStruct.annualSign)
            } label: {
                Text("Подчиненные:\n\(vm.subordinates(sign: customer.annualSignStruct))")
            }
            NavigationLink {
                BusinessView(business: subordinate, sign: customer.annualSignStruct.annualSign)
            } label: {
                Text("Советники:\n\(vm.advisers(sign: customer.annualSignStruct))")
            }
        }
    }
    var marriageSection: some View {
        Section("Брак:") {
            NavigationLink {
                MarriageView(marriage: vectorMarriage, sign: customer.annualSignStruct.annualSign)
            } label: {
                Text("Векторный брак: \(vm.vectorMarriage(sign: customer.annualSignStruct))")
            }
            NavigationLink {
                MarriageView(marriage: romanticMarriage, sign: customer.annualSignStruct.annualSign)
            } label: {
                Text("Романтический брак: \(vm.romanticMarriage(sign: customer.annualSignStruct))")
            }
            NavigationLink {
                MarriageView(marriage: patriarchalMarriage, sign: customer.annualSignStruct.annualSign)
            } label: {
                Text("Патриархальный брак: \(vm.patriarchalMarriage(sign: customer.annualSignStruct))")
            }
            NavigationLink {
                MarriageView(marriage: spiritualMarriage, sign: customer.annualSignStruct.annualSign)
            } label: {
                Text("Духовный брак: \(vm.spiritualMarriage(sign: customer.annualSignStruct))")
            }
            NavigationLink {
                MarriageView(marriage: equalMarriage, sign: customer.annualSignStruct.annualSign)
            } label: {
                Text("Равный брак: \(vm.equalMarriage(sign: customer.annualSignStruct))")
            }
        }
    }
}
