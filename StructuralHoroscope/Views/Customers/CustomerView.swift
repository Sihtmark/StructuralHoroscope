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
    
    var dateRange: ClosedRange<Date> {
        var dateComponents = DateComponents()
        dateComponents.year = 1850
        dateComponents.month = 1
        dateComponents.day = 1
        let calendar = Calendar(identifier: .gregorian)
        let min = calendar.date(from: dateComponents)!
        let max = Date()
        return min...max
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
        .scrollIndicators(ScrollIndicatorVisibility.hidden)
        .frame(maxWidth: 550)
        .listStyle(.inset)
        .navigationTitle(customer.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(isEditing ? "Сохранить" : "Изменить") {
                    if isEditing {
                        vm.updateCustomer(client: customer, name: name, sex: sex, birthday: selectedDate, sign: vm.getAnnualSign(date: selectedDate)!, zodiacSign: vm.getZodiacSign(date: selectedDate)!)
                        customer = customer.updateInfo(name: name, sex: sex, birthday: selectedDate, sign: vm.getAnnualSign(date: selectedDate)!, month: vm.getZodiacSign(date: selectedDate)!, isFavorite: false)
                    }
                    isEditing.toggle()
                }
                .disabled(name.count < 3)
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
                .preferredColorScheme(.dark)
        }
        .environmentObject(ViewModel())
        NavigationStack {
            CustomerView(customer: sampleClient)
                .preferredColorScheme(.light)
        }
        .environmentObject(ViewModel())
    }
}

extension CustomerView {
    var customerInfo: some View {
        Section {
            Text("🪪 Имя: \(customer.name)")
                .foregroundColor(.theme.standard)
            Text(customer.sex == .male ? "⚧️ Пол: мужской" : "⚧️ Пол: женский")
                .foregroundColor(.theme.standard)
            Text("🎂 Дата рождения: \(dateFormatter.string(from: customer.birthday))")
                .foregroundColor(.theme.standard)
            NavigationLink {
                AgeView(ageStruct: ages[vm.getAgeType(birthdate: selectedDate)]!)
            } label: {
                Text("💫 Возраст: \(vm.getAgeType(birthdate: selectedDate).rawValue)")
                    .foregroundColor(.theme.standard)
            }
        } header: {
            Text("Личные данные:")
                .foregroundColor(.theme.accent)
        }
        .listRowSeparator(.hidden)
    }
    
    var editCustomerInfo: some View {
        Section {
            HStack {
                Text("🪪 Имя:")
                    .foregroundColor(.theme.standard)
                TextField("Введите новое имя", text: $name)
                    .foregroundColor(.theme.standard)
                    .textFieldStyle(.roundedBorder)
            }
            HStack(spacing: 30) {
                Text("⚧️ Пол:")
                    .foregroundColor(.theme.standard)
                Picker(selection: $sex) {
                    Text("Мужской").tag(Sex.male)
                    Text("Женский").tag(Sex.female)
                } label: {
                    Text("asdf")
                        .foregroundColor(.theme.standard)
                }
                .pickerStyle(.segmented)
            }
            DatePicker("🎂 Дата рождения:", selection: $selectedDate, in: dateRange, displayedComponents: .date)
                .foregroundColor(.theme.standard)
                .environment(\.locale, Locale.init(identifier: "ru"))
            NavigationLink {
                AgeView(ageStruct: ages[vm.getAgeType(birthdate: selectedDate)]!)
            } label: {
                Text("💫 Возраст: \(vm.getAgeType(birthdate: selectedDate).rawValue)")
                    .foregroundColor(.theme.standard)
            }
        } header: {
            Text("Личные данные:")
                .foregroundColor(.theme.accent)
        }
        .listRowSeparator(.hidden)
    }
    
    var signSection: some View {
        Section {
            NavigationLink {
                annualSignDescription
            } label: {
                HStack {
                    Image("\(customer.annualSignStruct.annualSign)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    Text("Годовой знак: \(customer.annualSignStruct.annualSign.rawValue)")
                        .foregroundColor(.theme.standard)
                }
            }
            NavigationLink {
                virtualSignDescription
            } label: {
                HStack {
                    Text(customer.annualSignStruct.socialSigns[customer.month]!.emoji.rawValue)
                        .foregroundColor(.theme.standard)
                        .fixedSize()
                        .frame(width: 20, height: 20)
                    Text("Виртуальный знак: \(customer.annualSignStruct.socialSigns[customer.month]!.socialSign.rawValue)")
                        .foregroundColor(.theme.standard)
                }
            }
        } header: {
            Text("Знаки:")
                .foregroundColor(.theme.accent)
        }
        .listRowSeparator(.hidden)
    }
    
    var typeSection: some View {
        Section {
            NavigationLink {
                ideologicDescription
            } label: {
                Text("Тип мышления: \((customer.annualSignStruct.ideologicalType[customer.sex]!.ideologicalType.rawValue))")
                    .foregroundColor(.theme.standard)
            }
            NavigationLink {
                socialDescription
            } label: {
                Text("Социальный тип: \(customer.annualSignStruct.socialType.socialType.rawValue)")
                    .foregroundColor(.theme.standard)
            }
            NavigationLink {
                psychologicalDescription
            } label: {
                Text("Психологический тип: \(customer.annualSignStruct.psychologicalType.psychologicalType.rawValue)")
                    .foregroundColor(.theme.standard)
            }
            NavigationLink {
                energyDescription
            } label: {
                Text("Энергетический тип:\n\(customer.annualSignStruct.temperament.energyType.rawValue)")
                    .foregroundColor(.theme.standard)
            }
            NavigationLink {
                fateDescription
            } label: {
                Text("Тип судьбы: \(customer.annualSignStruct.fateType.fateType.rawValue)")
                    .foregroundColor(.theme.standard)
            }
        } header: {
            Text("Типы:")
                .foregroundColor(.theme.accent)
        }
        .listRowSeparator(.hidden)
    }
    
    var businessSection: some View {
        Section {
            NavigationLink {
                vectorHostDescription
            } label: {
                Text("Векторный хозяин: \(customer.annualSignStruct.vectorHost.rawValue)")
                    .foregroundColor(.theme.standard)
            }
            NavigationLink {
                vectorServantDescription
            } label: {
                Text("Векторный слуга:\(customer.annualSignStruct.vectorServant.rawValue)")
                    .foregroundColor(.theme.standard)
            }
            NavigationLink {
                cloneDescription
            } label: {
                Text("Клоны:\n\(customer.annualSignStruct.clones.map{$0.rawValue}.joined(separator: ", "))")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
            NavigationLink {
                companionDescription
            } label: {
                Text("Соратники:\n\(customer.annualSignStruct.companions.map{$0.rawValue}.joined(separator: ", "))")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
            NavigationLink {
                subordinateDescription
            } label: {
                Text("Подчиненные:\n\(customer.annualSignStruct.subordinates.map{$0.rawValue}.joined(separator: ", "))")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
            NavigationLink {
                adviserDescription
            } label: {
                Text("Советники:\n\(customer.annualSignStruct.advisers.map{$0.rawValue}.joined(separator: ", "))")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
        } header: {
            Text("Бизнес:")
                .foregroundColor(.theme.accent)
        }
        .listRowSeparator(.hidden)
    }
    
    var marriageSection: some View {
        Section {
            NavigationLink {
                vectorMarriageDescription
            } label: {
                Text("Векторный:\n\(customer.annualSignStruct.vectorHost.rawValue), \(customer.annualSignStruct.vectorServant.rawValue)")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
            NavigationLink {
                romanticMarriageDescription
            } label: {
                Text("Романтический:\n\(customer.annualSignStruct.romanticMarriage.map{$0.rawValue}.joined(separator: ", "))")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
            NavigationLink {
                patriarchalMarriageDescription
            } label: {
                Text("Патриархальный:\n\(customer.annualSignStruct.patriarchalMarriage.map{$0.rawValue}.joined(separator: ", "))")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
            NavigationLink {
                spiritualMarriageDescription
            } label: {
                Text("Духовный:\n\(customer.annualSignStruct.spiritualMarriage.map{$0.rawValue}.joined(separator: ", "))")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
            NavigationLink {
                equalMarriageDescription
            } label: {
                Text("Равный:\n\(customer.annualSignStruct.equalMarriage.map{$0.rawValue}.joined(separator: ", "))")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
        } header: {
            Text("Брак:")
                .foregroundColor(.theme.accent)
        }
        .listRowSeparator(.hidden)
    }
    
    var annualSignDescription: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                HStack {
                    Spacer()
                    Image("\(customer.annualSignStruct.annualSign)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                        .padding(.trailing,12)
                    Text(customer.annualSignStruct.annualSign.rawValue)
                        .foregroundColor(.theme.standard)
                        .font(.title)
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 15)
                ForEach(customer.annualSignStruct.blocks.sorted(by: <), id: \.key) { title, text in
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Spacer()
                            Text(title)
                                .foregroundColor(.theme.standard)
                                .font(.headline)
                                .bold()
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                        Text(text)
                            .foregroundColor(.theme.secondaryText)
                    }
                    .padding(.bottom, 25)
                }
            }
        }
        .padding(.horizontal)
    }
    
    var virtualSignDescription: some View {
        VStack(alignment: .leading) {
            ScrollView(showsIndicators: false) {
                HStack {
                    Spacer()
                    Text("\(customer.annualSignStruct.socialSigns[customer.month]!.emoji.rawValue) \(customer.annualSignStruct.socialSigns[customer.month]!.socialSign.rawValue)")
                        .foregroundColor(.theme.standard)
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding(.bottom, 15)
                ForEach(customer.annualSignStruct.socialSigns[customer.month]!.blocks.sorted(by: <), id: \.key) { title, text in
                    VStack(alignment: .leading) {
                        HStack {
                            Spacer()
                            Text(title)
                                .foregroundColor(.theme.standard)
                                .font(.headline)
                                .bold()
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                        Text(text)
                            .foregroundColor(.theme.secondaryText)
                            .padding(.bottom)
                    }
                }
            }
        }
        .padding(.horizontal)
    }
    
    var ideologicDescription: some View {
        VStack(alignment: .leading) {
            ScrollView(showsIndicators: false) {
                HStack {
                    Spacer()
                    Text(customer.annualSignStruct.ideologicalType[customer.sex]!.title)
                        .foregroundColor(.theme.standard)
                        .font(.headline)
                        .bold()
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding(.bottom, 15)
                Text(customer.annualSignStruct.ideologicalType[customer.sex]!.text)
                    .foregroundColor(.theme.secondaryText)
                    .padding(.bottom)
            }
        }
        .padding(.horizontal)
    }
    
    var socialDescription: some View {
        VStack(alignment: .leading) {
            ScrollView(showsIndicators: false) {
                HStack {
                    Spacer()
                    Text(customer.annualSignStruct.socialType.title)
                        .foregroundColor(.theme.standard)
                        .font(.headline)
                        .bold()
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding(.bottom, 15)
                Text(customer.annualSignStruct.socialType.text)
                    .foregroundColor(.theme.secondaryText)
                    .padding(.bottom)
            }
        }
        .padding(.horizontal)
    }
    
    var psychologicalDescription: some View {
        VStack(alignment: .leading) {
            ScrollView(showsIndicators: false) {
                HStack {
                    Spacer()
                    Text(customer.annualSignStruct.psychologicalType.title)
                        .foregroundColor(.theme.standard)
                        .font(.headline)
                        .bold()
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding(.bottom, 15)
                Text(customer.annualSignStruct.psychologicalType.text)
                    .foregroundColor(.theme.secondaryText)
                    .padding(.bottom)
            }
        }
        .padding(.horizontal)
    }
    
    var energyDescription: some View {
        VStack(alignment: .leading) {
            ScrollView(showsIndicators: false) {
                HStack {
                    Spacer()
                    Text(customer.annualSignStruct.temperament.title)
                        .foregroundColor(.theme.standard)
                        .font(.headline)
                        .bold()
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding(.bottom, 15)
                Text(customer.annualSignStruct.temperament.text)
                    .foregroundColor(.theme.secondaryText)
                    .padding(.bottom)
            }
        }
        .padding(.horizontal)
    }
    
    var fateDescription: some View {
        VStack(alignment: .leading) {
            ScrollView(showsIndicators: false) {
                HStack {
                    Spacer()
                    Text(customer.annualSignStruct.fateType.title)
                        .foregroundColor(.theme.standard)
                        .font(.headline)
                        .bold()
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding(.bottom, 15)
                Text(customer.annualSignStruct.fateType.text)
                    .foregroundColor(.theme.secondaryText)
                    .padding(.bottom)
            }
        }
        .padding(.horizontal)
    }
    
    var vectorHostDescription: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Text(vectorHost.type.rawValue)
                    .foregroundColor(.theme.standard)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            HStack {
                Text(vectorHost.value)
                    .foregroundColor(.theme.secondaryText)
                    .padding(.bottom,15)
                Spacer()
            }
            Text(vectorHost.text)
                .foregroundColor(.theme.secondaryText)
                .padding(.bottom)
            Spacer()
        }
        .padding(.horizontal)
    }
    
    var vectorServantDescription: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Text(vectorServant.type.rawValue)
                    .foregroundColor(.theme.standard)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            HStack {
                Text(vectorServant.value)
                    .foregroundColor(.theme.secondaryText)
                    .padding(.bottom,15)
                Spacer()
            }
            Text(vectorServant.text)
                .foregroundColor(.theme.secondaryText)
                .padding(.bottom)
            Spacer()
        }
        .padding(.horizontal)
    }
    
    var cloneDescription: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Text(clone.type.rawValue)
                    .foregroundColor(.theme.standard)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            HStack {
                Text(clone.value)
                    .foregroundColor(.theme.secondaryText)
                    .padding(.bottom,15)
                Spacer()
            }
            Text(clone.text)
                .foregroundColor(.theme.secondaryText)
                .padding(.bottom)
            Spacer()
        }
        .padding(.horizontal)
    }
    
    var companionDescription: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Text(companion.type.rawValue)
                    .foregroundColor(.theme.standard)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            HStack {
                Text(companion.value)
                    .foregroundColor(.theme.secondaryText)
                    .padding(.bottom,15)
                Spacer()
            }
            Text(companion.text)
                .foregroundColor(.theme.secondaryText)
                .padding(.bottom)
            Spacer()
        }
        .padding(.horizontal)
    }
    
    var subordinateDescription: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Text(subordinate.type.rawValue)
                    .foregroundColor(.theme.standard)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            HStack {
                Text(subordinate.value)
                    .foregroundColor(.theme.secondaryText)
                    .padding(.bottom,15)
                Spacer()
            }
            Text(subordinate.text)
                .foregroundColor(.theme.secondaryText)
                .padding(.bottom)
            Spacer()
        }
        .padding(.horizontal)
    }
    
    var adviserDescription: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Text(adviser.type.rawValue)
                    .foregroundColor(.theme.standard)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            HStack {
                Text(adviser.value)
                    .foregroundColor(.theme.secondaryText)
                    .padding(.bottom,15)
                Spacer()
            }
            Text(adviser.text)
                .foregroundColor(.theme.secondaryText)
                .padding(.bottom)
            Spacer()
        }
        .padding(.horizontal)
    }
    
    var vectorMarriageDescription: some View {
        ScrollView(showsIndicators: false) {
            HStack {
                Spacer()
                Text(vectorMarriage.title)
                    .foregroundColor(.theme.standard)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            Text(vectorMarriage.text)
                .foregroundColor(.theme.secondaryText)
                .padding(.bottom)
            Spacer()
        }
        .padding(.horizontal)
    }
    
    var romanticMarriageDescription: some View {
        ScrollView(showsIndicators: false) {
            HStack {
                Spacer()
                Text(romanticMarriage.title)
                    .foregroundColor(.theme.standard)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            Text(romanticMarriage.text)
                .foregroundColor(.theme.secondaryText)
                .padding(.bottom)
            Spacer()
        }
        .padding(.horizontal)
    }
    
    var patriarchalMarriageDescription: some View {
        ScrollView(showsIndicators: false) {
            HStack {
                Spacer()
                Text(patriarchalMarriage.title)
                    .foregroundColor(.theme.standard)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            Text(patriarchalMarriage.text)
                .foregroundColor(.theme.secondaryText)
                .padding(.bottom)
            Spacer()
        }
        .padding(.horizontal)
    }
    
    var spiritualMarriageDescription: some View {
        ScrollView(showsIndicators: false) {
            HStack {
                Spacer()
                Text(spiritualMarriage.title)
                    .foregroundColor(.theme.standard)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            Text(spiritualMarriage.text)
                .foregroundColor(.theme.secondaryText)
                .padding(.bottom)
            Spacer()
        }
        .padding(.horizontal)
    }
    
    var equalMarriageDescription: some View {
        ScrollView(showsIndicators: false) {
            HStack {
                Spacer()
                Text(equalMarriage.title)
                    .foregroundColor(.theme.standard)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            Text(equalMarriage.text)
                .foregroundColor(.theme.secondaryText)
                .padding(.bottom)
            Spacer()
        }
        .padding(.horizontal)
    }
}
