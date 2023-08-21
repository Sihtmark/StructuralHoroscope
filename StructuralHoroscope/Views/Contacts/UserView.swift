import SwiftUI

struct UserView: View {
    @EnvironmentObject var vm: ViewModel
    @State private var isEditing = false
    @State private var selectedDate = Date()
    @State private var sex: Sex = .male
    
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
        .navigationTitle("Мой профиль")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(isEditing ? "Сохранить" : "Изменить") {
                    if isEditing {
                        vm.updateUser(sex: sex, birthday: selectedDate, sign: vm.getAnnualSign(date: selectedDate)!, zodiacSign: vm.getMonth(date: selectedDate)!)
                    }
                    isEditing.toggle()
                }
            }
        }
        .onAppear {
            selectedDate = vm.user!.birthday
            sex = vm.user!.sex
        }
    }
}

struct MainCustomerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            UserView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(ViewModel())
        NavigationStack {
            UserView()
                .preferredColorScheme(.light)
        }
        .environmentObject(ViewModel())
    }
}

extension UserView {
    var customerInfo: some View {
        Section {
            Text(vm.user!.sex == .male ? "⚧️ Пол: мужской" : "⚧️ Пол: женский")
                .foregroundColor(.theme.standard)
            Text("🎂 Дата рождения: \(DateManager.instance.dateFormatter.string(from: vm.user!.birthday))")
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
            HStack(spacing: 30) {
                Text("⚧️ Пол:")
                Picker(selection: $sex) {
                    Text("Мужской").tag(Sex.male)
                        .foregroundColor(.theme.standard)
                    Text("Женский").tag(Sex.female)
                        .foregroundColor(.theme.standard)
                } label: {
                    Text("")
                        .foregroundColor(.theme.standard)
                }
                .pickerStyle(.segmented)
            }
            DatePicker("🎂 Дата рождения:", selection: $selectedDate, in: DateManager.instance.dateRange, displayedComponents: .date)
                .foregroundColor(.theme.standard)
                .environment(\.locale, Locale(identifier: "ru"))
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
                    Image("\(vm.user!.annualSignStruct.annualSign)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    Text("Годовой знак: \(vm.user!.annualSignStruct.annualSign.rawValue)")
                        .foregroundColor(.theme.standard)
                }
            }
            NavigationLink {
                virtualSignDescription
            } label: {
                HStack {
                    Text(vm.user!.annualSignStruct.socialSigns[vm.user!.month]!.emoji.rawValue)
                        .foregroundColor(.theme.standard)
                        .fixedSize()
                        .frame(width: 20, height: 20)
                    Text("Виртуальный знак: \(vm.user!.annualSignStruct.socialSigns[vm.user!.month]!.socialSign.rawValue)")
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
                Text("Тип мышления: \(vm.user!.annualSignStruct.ideologicalType[vm.user!.sex]!.ideologicalType.rawValue)")
                    .foregroundColor(.theme.standard)
            }
            NavigationLink {
                socialDescription
            } label: {
                Text("Социальный тип: \(vm.user!.annualSignStruct.socialType.socialType.rawValue)")
                    .foregroundColor(.theme.standard)
            }
            NavigationLink {
                psychologicalDescription
            } label: {
                Text("Психологический тип: \(vm.user!.annualSignStruct.psychologicalType.psychologicalType.rawValue)")
                    .foregroundColor(.theme.standard)
            }
            NavigationLink {
                energyDescription
            } label: {
                Text("Энергетический тип:\n\(vm.user!.annualSignStruct.temperament.energyType.rawValue)")
                    .foregroundColor(.theme.standard)
            }
            NavigationLink {
                fateDescription
            } label: {
                Text("Тип судьбы: \(vm.user!.annualSignStruct.fateType.fateType.rawValue)")
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
                Text("Векторный хозяин:\n\(vm.user!.annualSignStruct.vectorHost.rawValue)")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
            NavigationLink {
                vectorServantDescription
            } label: {
                Text("Векторный слуга:\n\(vm.user!.annualSignStruct.vectorServant.rawValue)")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
            NavigationLink {
                cloneDescription
            } label: {
                Text("Клоны:\n\(vm.user!.annualSignStruct.clones.map { $0.rawValue }.joined(separator: ", "))")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
            NavigationLink {
                companionDescription
            } label: {
                Text("Соратники:\n\(vm.user!.annualSignStruct.companions.map { $0.rawValue }.joined(separator: ", "))")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
            NavigationLink {
                subordinateDescription
            } label: {
                Text("Подчиненные:\n\(vm.user!.annualSignStruct.subordinates.map { $0.rawValue }.joined(separator: ", "))")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
            NavigationLink {
                adviserDescription
            } label: {
                Text("Советники:\n\(vm.user!.annualSignStruct.advisers.map { $0.rawValue }.joined(separator: ", "))")
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
                Text("Векторный брак:\n\(vm.user!.annualSignStruct.vectorHost.rawValue), \(vm.user!.annualSignStruct.vectorServant.rawValue)")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
            NavigationLink {
                romanticMarriageDescription
            } label: {
                Text("Романтический брак:\n\(vm.user!.annualSignStruct.romanticMarriage.map { $0.rawValue }.joined(separator: ", "))")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
            NavigationLink {
                patriarchalMarriageDescription
            } label: {
                Text("Патриархальный брак:\n\(vm.user!.annualSignStruct.patriarchalMarriage.map { $0.rawValue }.joined(separator: ", "))")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
            NavigationLink {
                spiritualMarriageDescription
            } label: {
                Text("Духовный брак:\n\(vm.user!.annualSignStruct.spiritualMarriage.map { $0.rawValue }.joined(separator: ", "))")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
            NavigationLink {
                equalMarriageDescription
            } label: {
                Text("Равный брак:\n\(vm.user!.annualSignStruct.equalMarriage.map { $0.rawValue }.joined(separator: ", "))")
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
                    Image("\(vm.user!.annualSignStruct.annualSign)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                        .padding(.trailing, 12)
                    Text(vm.user!.annualSignStruct.annualSign.rawValue)
                        .foregroundColor(.theme.standard)
                        .font(.title)
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 15)
                ForEach(vm.user!.annualSignStruct.blocks.sorted(by: <), id: \.key) { title, text in
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
        .padding(.horizontal)
    }
    
    var virtualSignDescription: some View {
        VStack(alignment: .leading) {
            ScrollView(showsIndicators: false) {
                HStack {
                    Spacer()
                    Text("\(vm.user!.annualSignStruct.socialSigns[vm.user!.month]!.emoji.rawValue) \(vm.user!.annualSignStruct.socialSigns[vm.user!.month]!.socialSign.rawValue)")
                        .foregroundColor(.theme.standard)
                        .font(.title)
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 15)
                ForEach(vm.user!.annualSignStruct.socialSigns[vm.user!.month]!.blocks.sorted(by: <), id: \.key) { title, text in
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
        .padding(.horizontal)
    }
    
    var ideologicDescription: some View {
        VStack(alignment: .leading) {
            ScrollView(showsIndicators: false) {
                HStack {
                    Spacer()
                    Text(vm.user!.annualSignStruct.ideologicalType[vm.user!.sex]!.title)
                        .foregroundColor(.theme.standard)
                        .font(.headline)
                        .bold()
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding(.bottom, 15)
                Text(vm.user!.annualSignStruct.ideologicalType[vm.user!.sex]!.text)
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
                    Text(vm.user!.annualSignStruct.socialType.title)
                        .foregroundColor(.theme.standard)
                        .font(.headline)
                        .bold()
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding(.bottom, 15)
                Text(vm.user!.annualSignStruct.socialType.text)
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
                    Text(vm.user!.annualSignStruct.psychologicalType.title)
                        .foregroundColor(.theme.standard)
                        .font(.headline)
                        .bold()
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding(.bottom, 15)
                Text(vm.user!.annualSignStruct.psychologicalType.text)
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
                    Text(vm.user!.annualSignStruct.temperament.title)
                        .foregroundColor(.theme.standard)
                        .font(.headline)
                        .bold()
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding(.bottom, 15)
                Text(vm.user!.annualSignStruct.temperament.text)
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
                    Text(vm.user!.annualSignStruct.fateType.title)
                        .foregroundColor(.theme.standard)
                        .font(.headline)
                        .bold()
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding(.bottom, 15)
                Text(vm.user!.annualSignStruct.fateType.text)
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
                    .padding(.bottom, 15)
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
                    .padding(.bottom, 15)
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
                    .padding(.bottom, 15)
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
                    .padding(.bottom, 15)
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
                    .padding(.bottom, 15)
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
                    .padding(.bottom, 15)
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
