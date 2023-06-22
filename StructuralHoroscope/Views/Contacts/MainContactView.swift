//
//  MainContactView.swift
//  SmartRelations
//
//  Created by Sergei Poluboiarinov on 22.06.2023.
//

import SwiftUI

struct MainContactView: View {
    
    @EnvironmentObject var vm: ViewModel
    @State var contact: ContactStruct
    @State private var isEditing = false
    @State private var name = ""
    @State private var selectedDate = Date()
    @State private var sex: Sex = .male
    @State private var isAdding = false
    @State private var date = Date()
    @State private var feeling = Feelings.notTooBad
    @State private var describe = ""
    @State private var isFavorite = false
    @State private var isEditingMeeting: Meeting? = nil
    
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
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }
    
    var body: some View {
        VStack {
            if contact.contact != nil {
                ScrollView {
                    titleSection
                    eventsSection
                }
            } else {
                List {
                    customerInfo
                    typeSection
                    businessSection
                    marriageSection
                }
                .listStyle(.inset)
                .navigationTitle(contact.name)
            }
        }
        .ignoresSafeArea(edges: .bottom)
        .scrollIndicators(ScrollIndicatorVisibility.hidden)
        .frame(maxWidth: 550)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(isEditing ? "Сохранить" : "Изменить") {
                    isEditing.toggle()
                }
                .disabled(name.count < 3)
            }
        }
        .sheet(isPresented: $isEditing, content: {
            ChangeContactView(contact: $contact)
                .presentationDragIndicator(.visible)
        })
        .sheet(isPresented: $isAdding, content: {
            addMeetingSheet
                .presentationDragIndicator(.visible)
        })
        .sheet(item: $isEditingMeeting, content: { meeting in
            MeetingView(meeting: meeting, contact: $contact)
                .presentationDragIndicator(.visible)
        })
        .onAppear {
            name = contact.name
            selectedDate = contact.birthday
            sex = contact.sex
            isFavorite = contact.isFavorite
        }
    }
}

struct MainContactView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MainContactView(contact: sampleContact)
                .preferredColorScheme(.light)
        }
        .environmentObject(ViewModel())
    }
}


// MARK: if user will track calls and meetings
extension MainContactView {
    
    var titleSection: some View {
        VStack(spacing: 15) {
            NavigationLink {
                ContactInfoView(contact: contact)
            } label: {
                ZStack {
                    Circle()
                        .fill(.white)
                        .frame(width: 80)
                        .shadow(radius: 3)
                    Circle()
                        .fill(Color(uiColor: .secondarySystemFill))
                        .frame(width: 77)
                    Image("\(contact.annualSignStruct.annualSign)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 45)
                }
            }
            VStack {
                Text(contact.name)
                    .font(.title)
                    .foregroundColor(.theme.standard)
                Text("\(vm.returnBusinessSing(sign: vm.ourBusinessRelationship(customer: contact)))")
                    .font(.callout)
                    .foregroundColor(.theme.secondaryText)
            }
            if let contact = contact.contact {
                VStack(spacing: 5) {
                    Text("Последнее общение \(dateFormatter.string(from: contact.lastContact))")
                    Text(vm.daysFromLastEvent(lastEvent: contact.lastContact))
                }
                .font(.callout)
                .foregroundColor(vm.getNextEventDate(component: contact.component, lastContact: contact.lastContact, interval: contact.distance) > Date() ? .theme.green : .theme.red)
                ZStack {
                    Button {
                        isFavorite.toggle()
                        vm.toggleFavorite(contact: self.contact)
                    } label: {
                        ZStack {
                            Image(systemName: isFavorite ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                        }
                    }
                    .offset(x: 100)
                    Button {
                        isAdding.toggle()
                    } label: {
                        Label("Добавить", systemImage: "plus")
                    }
                    .buttonStyle(.bordered)
                    .padding(.top, 5)
                }
            }
        }
    }
    
    var eventsSection: some View {
        ForEach(contact.contact!.allEvents.sorted(by: {$0.date > $1.date})) { event in
            Button {
                isEditingMeeting = event
            } label: {
                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.theme.accent, lineWidth: 0.4)
                        .frame(maxWidth: .infinity)
                    VStack(alignment: .leading, spacing: 6) {
                        HStack() {
                            Text(event.feeling.rawValue)
                            Text(dateFormatter.string(from: event.date))
                                .foregroundColor(.theme.accent)
                        }
                        Text(event.describe)
                            .foregroundColor(.theme.secondaryText)
                            .font(.callout)
                            .multilineTextAlignment(.leading)
                    }
                    .padding()
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
            }
        }
    }
    
    var addMeetingSheet: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                HStack {
                    Spacer()
                    DatePicker(selection: $date, in: dateRange, displayedComponents: .date) {}
                        .foregroundColor(.theme.accent)
                        .datePickerStyle(.wheel)
                        .frame(width: 320, height: 180)
                        .padding(.trailing, 7.5)
                        .overlay(alignment: .bottom) {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.gray.opacity(0.2))
                                .allowsHitTesting(false)
                        }
                    Spacer()
                }
                .padding(.top, 20)
                Picker("", selection: $feeling) {
                    ForEach(Feelings.allCases, id: \.self) { feeling in
                        Text(feeling.rawValue).tag(feeling)
                    }
                }
                .pickerStyle(.segmented)
                TextEditor(text: $describe)
                    .frame(minHeight: 30)
                    .foregroundColor(.theme.secondaryText)
                    .padding(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.gray.opacity(0.2))
                            .allowsHitTesting(false)
                    }
                HStack {
                    Spacer()
                    Button {
                        vm.addMeeting(contact: contact, date: date, feeling: feeling, describe: describe)
                        contact = contact.addMeeting(contact: contact.contact!, date: date, feeling: feeling, describe: describe)
                        contact.contact!.lastContact = contact.contact!.allEvents.map{$0.date}.max()!
                        if let i = vm.contacts.firstIndex(where: {$0.id == contact.id}) {
                            vm.contacts[i].contact!.lastContact = contact.contact!.allEvents.map{$0.date}.max()!
                        }
                        isAdding.toggle()
                        date = Date()
                        feeling = .notTooBad
                        describe = ""
                    } label: {
                        Text("Сохранить")
                            .bold()
                            .padding(10)
                            .padding(.horizontal)
                    }
                    .buttonStyle(.borderedProminent)
                    Spacer()
                }
                Spacer()
            }
        }
        .padding()
    }
    
}

//MARK: if user will not track calls and meetings of this contact
extension MainContactView {
    var customerInfo: some View {
        Section {
            Text(contact.sex == .male ? "⚧️ Пол: мужской" : "⚧️ Пол: женский")
                .foregroundColor(.theme.standard)
            Text("🎂 Дата рождения: \(dateFormatter.string(from: contact.birthday))")
                .foregroundColor(.theme.standard)
            NavigationLink {
                annualSignDescription
            } label: {
                HStack {
                    Image("\(contact.annualSignStruct.annualSign)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    Text("Годовой знак: \(contact.annualSignStruct.annualSign.rawValue)")
                        .foregroundColor(.theme.standard)
                }
            }
            NavigationLink {
                virtualSignDescription
            } label: {
                HStack {
                    Text(contact.annualSignStruct.socialSigns[contact.month]!.emoji.rawValue)
                        .foregroundColor(.theme.standard)
                        .fixedSize()
                        .frame(width: 20, height: 20)
                    Text("Виртуальный знак: \(contact.annualSignStruct.socialSigns[contact.month]!.socialSign.rawValue)")
                        .foregroundColor(.theme.standard)
                }
            }
            NavigationLink {
                AgeView(ageStruct: ages[vm.getAgeType(birthdate: contact.birthday)]!)
            } label: {
                Text("💫 Возраст: \(vm.getAgeType(birthdate: contact.birthday).rawValue)")
                    .foregroundColor(.theme.standard)
            }
        } header: {
            Text("Личные данные:")
                .foregroundColor(.theme.accent)
        }
        .listRowSeparator(.hidden)
    }
    
    var typeSection: some View {
        Section {
            NavigationLink {
                ideologicDescription
            } label: {
                Text("Тип мышления: \((contact.annualSignStruct.ideologicalType[contact.sex]!.ideologicalType.rawValue))")
                    .foregroundColor(.theme.standard)
            }
            NavigationLink {
                socialDescription
            } label: {
                Text("Социальный тип: \(contact.annualSignStruct.socialType.socialType.rawValue)")
                    .foregroundColor(.theme.standard)
            }
            NavigationLink {
                psychologicalDescription
            } label: {
                Text("Психологический тип: \(contact.annualSignStruct.psychologicalType.psychologicalType.rawValue)")
                    .foregroundColor(.theme.standard)
            }
            NavigationLink {
                energyDescription
            } label: {
                Text("Энергетический тип:\n\(contact.annualSignStruct.temperament.energyType.rawValue)")
                    .foregroundColor(.theme.standard)
            }
            NavigationLink {
                fateDescription
            } label: {
                Text("Тип судьбы: \(contact.annualSignStruct.fateType.fateType.rawValue)")
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
                Text("Векторный хозяин: \(contact.annualSignStruct.vectorHost.rawValue)")
                    .foregroundColor(.theme.standard)
            }
            NavigationLink {
                vectorServantDescription
            } label: {
                Text("Векторный слуга:\(contact.annualSignStruct.vectorServant.rawValue)")
                    .foregroundColor(.theme.standard)
            }
            NavigationLink {
                cloneDescription
            } label: {
                Text("Клоны:\n\(contact.annualSignStruct.clones.map{$0.rawValue}.joined(separator: ", "))")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
            NavigationLink {
                companionDescription
            } label: {
                Text("Соратники:\n\(contact.annualSignStruct.companions.map{$0.rawValue}.joined(separator: ", "))")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
            NavigationLink {
                subordinateDescription
            } label: {
                Text("Подчиненные:\n\(contact.annualSignStruct.subordinates.map{$0.rawValue}.joined(separator: ", "))")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
            NavigationLink {
                adviserDescription
            } label: {
                Text("Советники:\n\(contact.annualSignStruct.advisers.map{$0.rawValue}.joined(separator: ", "))")
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
                Text("Векторный:\n\(contact.annualSignStruct.vectorHost.rawValue), \(contact.annualSignStruct.vectorServant.rawValue)")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
            NavigationLink {
                romanticMarriageDescription
            } label: {
                Text("Романтический:\n\(contact.annualSignStruct.romanticMarriage.map{$0.rawValue}.joined(separator: ", "))")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
            NavigationLink {
                patriarchalMarriageDescription
            } label: {
                Text("Патриархальный:\n\(contact.annualSignStruct.patriarchalMarriage.map{$0.rawValue}.joined(separator: ", "))")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
            NavigationLink {
                spiritualMarriageDescription
            } label: {
                Text("Духовный:\n\(contact.annualSignStruct.spiritualMarriage.map{$0.rawValue}.joined(separator: ", "))")
                    .foregroundColor(.theme.standard)
                    .lineSpacing(6)
            }
            NavigationLink {
                equalMarriageDescription
            } label: {
                Text("Равный:\n\(contact.annualSignStruct.equalMarriage.map{$0.rawValue}.joined(separator: ", "))")
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
                    Image("\(contact.annualSignStruct.annualSign)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                        .padding(.trailing,12)
                    Text(contact.annualSignStruct.annualSign.rawValue)
                        .foregroundColor(.theme.standard)
                        .font(.title)
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 15)
                ForEach(contact.annualSignStruct.blocks.sorted(by: <), id: \.key) { title, text in
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
                    Text("\(contact.annualSignStruct.socialSigns[contact.month]!.emoji.rawValue) \(contact.annualSignStruct.socialSigns[contact.month]!.socialSign.rawValue)")
                        .foregroundColor(.theme.standard)
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding(.bottom, 15)
                ForEach(contact.annualSignStruct.socialSigns[contact.month]!.blocks.sorted(by: <), id: \.key) { title, text in
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
                    Text(contact.annualSignStruct.ideologicalType[contact.sex]!.title)
                        .foregroundColor(.theme.standard)
                        .font(.headline)
                        .bold()
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding(.bottom, 15)
                Text(contact.annualSignStruct.ideologicalType[contact.sex]!.text)
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
                    Text(contact.annualSignStruct.socialType.title)
                        .foregroundColor(.theme.standard)
                        .font(.headline)
                        .bold()
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding(.bottom, 15)
                Text(contact.annualSignStruct.socialType.text)
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
                    Text(contact.annualSignStruct.psychologicalType.title)
                        .foregroundColor(.theme.standard)
                        .font(.headline)
                        .bold()
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding(.bottom, 15)
                Text(contact.annualSignStruct.psychologicalType.text)
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
                    Text(contact.annualSignStruct.temperament.title)
                        .foregroundColor(.theme.standard)
                        .font(.headline)
                        .bold()
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding(.bottom, 15)
                Text(contact.annualSignStruct.temperament.text)
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
                    Text(contact.annualSignStruct.fateType.title)
                        .foregroundColor(.theme.standard)
                        .font(.headline)
                        .bold()
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding(.bottom, 15)
                Text(contact.annualSignStruct.fateType.text)
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

