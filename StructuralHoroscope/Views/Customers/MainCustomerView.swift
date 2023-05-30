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
                .disabled(name.count < 3)
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
                .preferredColorScheme(.dark)
        }
        .environmentObject(ViewModel())
        NavigationStack {
            MainCustomerView()
                .preferredColorScheme(.light)
        }
        .environmentObject(ViewModel())
    }
}

extension MainCustomerView {
    var customerInfo: some View {
        Section {
            Text("🪪 Имя: \(vm.mainUser.name)")
                .foregroundColor(.theme.standard)
            Text(vm.mainUser.sex == .male ? "⚧️ Пол: мужской" : "⚧️ Пол: женский")
                .foregroundColor(.theme.standard)
            Text("🎂 Дата рождения: \(dateFormatter.string(from: vm.mainUser.birthday))")
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
                Picker(selection: $sex) {
                    Text("Мужской").tag(Sex.male)
                        .foregroundColor(.theme.standard)
                    Text("Женский").tag(Sex.female)
                        .foregroundColor(.theme.standard)
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
            HStack {
                Image("\(vm.mainUser.zodiacSign)Small")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                Text("Знак Зодиака: \(vm.mainUser.zodiacSign.rawValue)")
                    .foregroundColor(.theme.standard)
            }
            NavigationLink {
                annualSignDescription
            } label: {
                HStack {
                    Image("\(vm.mainUser.annualSignStruct.annualSign)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    Text("Годовой знак: \(vm.mainUser.annualSignStruct.annualSign.rawValue)")
                        .foregroundColor(.theme.standard)
                }
            }
            NavigationLink {
                virtualSignDescription
            } label: {
                HStack {
                    Text(vm.mainUser.annualSignStruct.virtualSigns[vm.mainUser.zodiacSign]!.emoji.rawValue)
                        .foregroundColor(.theme.standard)
                        .fixedSize()
                        .frame(width: 20, height: 20)
                    Text("Виртуальный знак: \(vm.mainUser.annualSignStruct.virtualSigns[vm.mainUser.zodiacSign]!.virtualSign.rawValue)")
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
                Text("Тип мышления: \((vm.mainUser.annualSignStruct.ideologicalType[vm.mainUser.sex]!.ideologicalType.rawValue))")
                    .foregroundColor(.theme.standard)
            }
            NavigationLink {
                socialDescription
            } label: {
                Text("Социальный тип: \(vm.mainUser.annualSignStruct.socialType.socialType.rawValue)")
                    .foregroundColor(.theme.standard)
            }
            NavigationLink {
                psychologicalDescription
            } label: {
                Text("Психологический тип: \(vm.mainUser.annualSignStruct.psychologicalType.psychologicalType.rawValue)")
                    .foregroundColor(.theme.standard)
            }
            NavigationLink {
                energyDescription
            } label: {
                Text("Энергетический тип:\n\(vm.mainUser.annualSignStruct.temperament.energyType.rawValue)")
                    .foregroundColor(.theme.standard)
            }
            NavigationLink {
                fateDescription
            } label: {
                Text("Тип судьбы: \(vm.mainUser.annualSignStruct.fateType.fateType.rawValue)")
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
                Text("Векторный хозяин:\n\(vm.hostString(sign: vm.mainUser.annualSignStruct.vectorHost))")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
            NavigationLink {
                vectorServantDescription
            } label: {
                Text("Векторный слуга:\n\(vm.servantString(sign: vm.mainUser.annualSignStruct.vectorServant))")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
            NavigationLink {
                cloneDescription
            } label: {
                Text("Клоны:\n\(vm.clones(sign: vm.mainUser.annualSignStruct))")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
            NavigationLink {
                companionDescription
            } label: {
                Text("Соратники:\n\(vm.companions(sign: vm.mainUser.annualSignStruct))")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
            NavigationLink {
                subordinateDescription
            } label: {
                Text("Подчиненные:\n\(vm.subordinates(sign: vm.mainUser.annualSignStruct))")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
            NavigationLink {
                adviserDescription
            } label: {
                Text("Советники:\n\(vm.advisers(sign: vm.mainUser.annualSignStruct))")
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
                Text("Векторный:\n\(vm.vectorMarriage(sign: vm.mainUser.annualSignStruct))")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
            NavigationLink {
                romanticMarriageDescription
            } label: {
                Text("Романтический:\n\(vm.romanticMarriage(sign: vm.mainUser.annualSignStruct))")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
            NavigationLink {
                patriarchalMarriageDescription
            } label: {
                Text("Патриархальный:\n\(vm.patriarchalMarriage(sign: vm.mainUser.annualSignStruct))")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
            NavigationLink {
                spiritualMarriageDescription
            } label: {
                Text("Духовный:\n\(vm.spiritualMarriage(sign: vm.mainUser.annualSignStruct))")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
            NavigationLink {
                equalMarriageDescription
            } label: {
                Text("Равный:\n\(vm.equalMarriage(sign: vm.mainUser.annualSignStruct))")
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
                    Image("\(vm.mainUser.annualSignStruct.annualSign)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                        .padding(.trailing,12)
                    Text(vm.mainUser.annualSignStruct.annualSign.rawValue)
                        .foregroundColor(.theme.standard)
                        .font(.title)
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 15)
                ForEach(vm.mainUser.annualSignStruct.blocks.sorted(by: <), id: \.key) { title, text in
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Spacer()
                            Text(title)
                                .foregroundColor(.theme.standard)
                                .font(.headline)
                                .bold()
                            Spacer()
                        }
                        Text(text)
                            .foregroundColor(.theme.secondaryText)
                    }
                    .padding(.bottom, 25)
                }
            }
        }
        .padding()
    }
    
    var virtualSignDescription: some View {
        VStack(alignment: .leading) {
            ScrollView(showsIndicators: false) {
                HStack {
                    Spacer()
                    Text("\(vm.mainUser.annualSignStruct.virtualSigns[vm.mainUser.zodiacSign]!.emoji.rawValue) \(vm.mainUser.annualSignStruct.virtualSigns[vm.mainUser.zodiacSign]!.virtualSign.rawValue)")
                        .foregroundColor(.theme.standard)
                        .font(.title)
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 15)
                ForEach(vm.mainUser.annualSignStruct.virtualSigns[vm.mainUser.zodiacSign]!.blocks.sorted(by: <), id: \.key) { title, text in
                    VStack(alignment: .leading) {
                        HStack {
                            Spacer()
                            Text(title)
                                .foregroundColor(.theme.standard)
                                .font(.headline)
                                .bold()
                            Spacer()
                        }
                        Text(text)
                            .foregroundColor(.theme.secondaryText)
                            .padding(.bottom)
                    }
                }
            }
        }
        .padding()
    }
    
    var ideologicDescription: some View {
        VStack(alignment: .leading) {
            ScrollView(showsIndicators: false) {
                HStack {
                    Spacer()
                    Text(vm.mainUser.annualSignStruct.ideologicalType[vm.mainUser.sex]!.title)
                        .foregroundColor(.theme.standard)
                        .font(.headline)
                        .bold()
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding(.bottom, 15)
                Text(vm.mainUser.annualSignStruct.ideologicalType[vm.mainUser.sex]!.text)
                    .foregroundColor(.theme.secondaryText)
                    .padding(.bottom)
            }
        }
        .padding()
    }
    
    var socialDescription: some View {
        VStack(alignment: .leading) {
            ScrollView(showsIndicators: false) {
                HStack {
                    Spacer()
                    Text(vm.mainUser.annualSignStruct.socialType.title)
                        .foregroundColor(.theme.standard)
                        .font(.headline)
                        .bold()
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding(.bottom, 15)
                Text(vm.mainUser.annualSignStruct.socialType.text)
                    .foregroundColor(.theme.secondaryText)
                    .padding(.bottom)
            }
        }
        .padding()
    }
    
    var psychologicalDescription: some View {
        VStack(alignment: .leading) {
            ScrollView(showsIndicators: false) {
                HStack {
                    Spacer()
                    Text(vm.mainUser.annualSignStruct.psychologicalType.title)
                        .foregroundColor(.theme.standard)
                        .font(.headline)
                        .bold()
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding(.bottom, 15)
                Text(vm.mainUser.annualSignStruct.psychologicalType.text)
                    .foregroundColor(.theme.secondaryText)
                    .padding(.bottom)
            }
        }
        .padding()
    }
    
    var energyDescription: some View {
        VStack(alignment: .leading) {
            ScrollView(showsIndicators: false) {
                HStack {
                    Spacer()
                    Text(vm.mainUser.annualSignStruct.temperament.title)
                        .foregroundColor(.theme.standard)
                        .font(.headline)
                        .bold()
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding(.bottom, 15)
                Text(vm.mainUser.annualSignStruct.temperament.text)
                    .foregroundColor(.theme.secondaryText)
                    .padding(.bottom)
            }
        }
        .padding()
    }
    
    var fateDescription: some View {
        VStack(alignment: .leading) {
            ScrollView(showsIndicators: false) {
                HStack {
                    Spacer()
                    Text(vm.mainUser.annualSignStruct.fateType.title)
                        .foregroundColor(.theme.standard)
                        .font(.headline)
                        .bold()
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding(.bottom, 15)
                Text(vm.mainUser.annualSignStruct.fateType.text)
                    .foregroundColor(.theme.secondaryText)
                    .padding(.bottom)
            }
        }
        .padding()
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
        .padding()
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
        .padding()
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
        .padding()
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
        .padding()
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
        .padding()
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
        .padding()
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
        .padding()
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
        .padding()
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
        .padding()
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
        .padding()
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
        .padding()
    }
}
