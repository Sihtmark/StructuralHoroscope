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
            } else {
                customerInfo
            }
            signSection
            typeSection
            businessSection
            marriageSection
        }
        .listStyle(.inset)
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
            NavigationLink {
                AgeView(age: ages[vm.getAgeType(birthdate: selectedDate)]!)
            } label: {
                Text("💫 Возраст: \(vm.getAgeType(birthdate: selectedDate).rawValue)")
            }
        }
    }
    
    var editCustomerInfo: some View {
        Section("Личные данные:") {
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
                Image("\(customer.zodiacSign)Small")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                Text("Знак Зодиака: \(customer.zodiacSign.rawValue)")
            }
            NavigationLink {
                annualSignDescription
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
                virtualSignDescription
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
                ideologicDescription
            } label: {
                Text("Тип мышления: \((customer.annualSignStruct.ideologicalType[customer.sex]!.ideologicalType.rawValue))")
            }
            NavigationLink {
                socialDescription
            } label: {
                Text("Социальный тип: \(customer.annualSignStruct.socialType.socialType.rawValue)")
            }
            NavigationLink {
                psychologicalDescription
            } label: {
                Text("Психологический тип: \(customer.annualSignStruct.psychologicalType.psychologicalType.rawValue)")
            }
            NavigationLink {
                energyDescription
            } label: {
                Text("Энергетический тип:\n\(customer.annualSignStruct.temperament.energyType.rawValue)")
            }
            NavigationLink {
                fateDescription
            } label: {
                Text("Тип судьбы: \(customer.annualSignStruct.fateType.fateType.rawValue)")
            }
        }
    }
    
    var businessSection: some View {
        Section("Бизнес:") {
            NavigationLink {
                vectorHostDescription
            } label: {
                Text("Векторный хозяин:\n\(vm.hostString(sign: customer.annualSignStruct.vectorHost))")
                    .lineSpacing(6)
            }
            NavigationLink {
                vectorServantDescription
            } label: {
                Text("Векторный слуга:\n\(vm.servantString(sign: customer.annualSignStruct.vectorServant))")
                    .lineSpacing(6)
            }
            NavigationLink {
                cloneDescription
            } label: {
                Text("Клоны:\n\(vm.clones(sign: customer.annualSignStruct))")
                    .lineSpacing(6)
            }
            NavigationLink {
                companionDescription
            } label: {
                Text("Соратники:\n\(vm.companions(sign: customer.annualSignStruct))")
                    .lineSpacing(6)
            }
            NavigationLink {
                subordinateDescription
            } label: {
                Text("Подчиненные:\n\(vm.subordinates(sign: customer.annualSignStruct))")
                    .lineSpacing(6)
            }
            NavigationLink {
                adviserDescription
            } label: {
                Text("Советники:\n\(vm.advisers(sign: customer.annualSignStruct))")
                    .lineSpacing(6)
            }
        }
    }
    
    var marriageSection: some View {
        Section("Брак:") {
            NavigationLink {
                vectorMarriageDescription
            } label: {
                Text("Векторный:\n\(vm.vectorMarriage(sign: customer.annualSignStruct))")
                    .lineSpacing(6)
            }
            NavigationLink {
                romanticMarriageDescription
            } label: {
                Text("Романтический:\n\(vm.romanticMarriage(sign: customer.annualSignStruct))")
                    .lineSpacing(6)
            }
            NavigationLink {
                patriarchalMarriageDescription
            } label: {
                Text("Патриархальный:\n\(vm.patriarchalMarriage(sign: customer.annualSignStruct))")
                    .lineSpacing(6)
            }
            NavigationLink {
                spiritualMarriageDescription
            } label: {
                Text("Духовный:\n\(vm.spiritualMarriage(sign: customer.annualSignStruct))")
                    .lineSpacing(6)
            }
            NavigationLink {
                equalMarriageDescription
            } label: {
                Text("Равный:\n\(vm.equalMarriage(sign: customer.annualSignStruct))")
                    .lineSpacing(6)
            }
        }
    }
    
    var annualSignDescription: some View {
        VStack {
            ScrollView {
                HStack {
                    Image("\(customer.annualSignStruct.annualSign)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                        .padding(.trailing,12)
                    Text(customer.annualSignStruct.annualSign.rawValue)
                        .font(.title)
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 15)
                ForEach(customer.annualSignStruct.blocks.sorted(by: <), id: \.key) { title, text in
                    VStack(alignment: .leading, spacing: 20) {
                        Text(title)
                            .font(.headline)
                            .bold()
                        Text(text)
                            .foregroundColor(.secondary)
                    }
                    .padding(.bottom, 25)
                }
            }
        }
        .padding()
    }
    
    var virtualSignDescription: some View {
        VStack(alignment: .leading) {
            ScrollView {
                HStack {
                    Text("\(customer.annualSignStruct.virtualSigns[customer.zodiacSign]!.emoji.rawValue) \(customer.annualSignStruct.virtualSigns[customer.zodiacSign]!.virtualSign.rawValue)")
                        .font(.title)
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 15)
                ForEach(customer.annualSignStruct.virtualSigns[customer.zodiacSign]!.blocks.sorted(by: <), id: \.key) { title, text in
                    VStack(alignment: .leading) {
                        Text(title)
                            .font(.headline)
                            .bold()
                        Text(text)
                            .foregroundColor(.secondary)
                            .padding(.bottom)
                    }
                }
            }
        }
        .padding()
    }
    
    var ideologicDescription: some View {
        VStack(alignment: .leading) {
            ScrollView {
                HStack {
                    Text(customer.annualSignStruct.ideologicalType[customer.sex]!.title)
                        .font(.headline)
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 15)
                Text(customer.annualSignStruct.ideologicalType[customer.sex]!.text)
                    .foregroundColor(.secondary)
                    .padding(.bottom)
            }
        }
        .padding()
    }
    
    var socialDescription: some View {
        VStack(alignment: .leading) {
            ScrollView {
                HStack {
                    Text(customer.annualSignStruct.socialType.title)
                        .font(.headline)
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 15)
                Text(customer.annualSignStruct.socialType.text)
                    .foregroundColor(.secondary)
                    .padding(.bottom)
            }
        }
        .padding()
    }
    
    var psychologicalDescription: some View {
        VStack(alignment: .leading) {
            ScrollView {
                HStack {
                    Text(customer.annualSignStruct.psychologicalType.title)
                        .font(.headline)
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 15)
                Text(customer.annualSignStruct.psychologicalType.text)
                    .foregroundColor(.secondary)
                    .padding(.bottom)
            }
        }
        .padding()
    }
    
    var energyDescription: some View {
        VStack(alignment: .leading) {
            ScrollView {
                HStack {
                    Text(customer.annualSignStruct.temperament.title)
                        .font(.headline)
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 15)
                Text(customer.annualSignStruct.temperament.text)
                    .foregroundColor(.secondary)
                    .padding(.bottom)
            }
        }
        .padding()
    }
    
    var fateDescription: some View {
        VStack(alignment: .leading) {
            ScrollView {
                HStack {
                    Text(customer.annualSignStruct.fateType.title)
                        .font(.headline)
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 15)
                Text(customer.annualSignStruct.fateType.text)
                    .foregroundColor(.secondary)
                    .padding(.bottom)
            }
        }
        .padding()
    }
    
    var vectorHostDescription: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(vectorHost.type.rawValue)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            HStack {
                Text(vectorHost.value)
                    .padding(.bottom,15)
                Spacer()
            }
            Text(vectorHost.text)
                .foregroundColor(.secondary)
                .padding(.bottom)
            Spacer()
        }
        .padding()
    }
    
    var vectorServantDescription: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(vectorServant.type.rawValue)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            HStack {
                Text(vectorServant.value)
                    .padding(.bottom,15)
                Spacer()
            }
            Text(vectorServant.text)
                .foregroundColor(.secondary)
                .padding(.bottom)
            Spacer()
        }
        .padding()
    }
    
    var cloneDescription: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(clone.type.rawValue)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            HStack {
                Text(clone.value)
                    .padding(.bottom,15)
                Spacer()
            }
            Text(clone.text)
                .foregroundColor(.secondary)
                .padding(.bottom)
            Spacer()
        }
        .padding()
    }
    
    var companionDescription: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(companion.type.rawValue)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            HStack {
                Text(companion.value)
                    .padding(.bottom,15)
                Spacer()
            }
            Text(companion.text)
                .foregroundColor(.secondary)
                .padding(.bottom)
            Spacer()
        }
        .padding()
    }
    
    var subordinateDescription: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(subordinate.type.rawValue)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            HStack {
                Text(subordinate.value)
                    .padding(.bottom,15)
                Spacer()
            }
            Text(subordinate.text)
                .foregroundColor(.secondary)
                .padding(.bottom)
            Spacer()
        }
        .padding()
    }
    
    var adviserDescription: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(adviser.type.rawValue)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            HStack {
                Text(adviser.value)
                    .padding(.bottom,15)
                Spacer()
            }
            Text(adviser.text)
                .foregroundColor(.secondary)
                .padding(.bottom)
            Spacer()
        }
        .padding()
    }
    
    var vectorMarriageDescription: some View {
        ScrollView {
            HStack {
                Text(vectorMarriage.title)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            Text(vectorMarriage.text)
                .foregroundColor(.secondary)
                .padding(.bottom)
            Spacer()
        }
        .padding()
    }
    
    var romanticMarriageDescription: some View {
        ScrollView {
            HStack {
                Text(romanticMarriage.title)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            Text(romanticMarriage.text)
                .foregroundColor(.secondary)
                .padding(.bottom)
            Spacer()
        }
        .padding()
    }
    
    var patriarchalMarriageDescription: some View {
        ScrollView {
            HStack {
                Text(patriarchalMarriage.title)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            Text(patriarchalMarriage.text)
                .foregroundColor(.secondary)
                .padding(.bottom)
            Spacer()
        }
        .padding()
    }
    
    var spiritualMarriageDescription: some View {
        ScrollView {
            HStack {
                Text(spiritualMarriage.title)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            Text(spiritualMarriage.text)
                .foregroundColor(.secondary)
                .padding(.bottom)
            Spacer()
        }
        .padding()
    }
    
    var equalMarriageDescription: some View {
        ScrollView {
            HStack {
                Text(equalMarriage.title)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            Text(equalMarriage.text)
                .foregroundColor(.secondary)
                .padding(.bottom)
            Spacer()
        }
        .padding()
    }
}
