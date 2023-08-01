//
//  ContactInfoView.swift
//  SmartRelations
//
//  Created by Sergei Poluboiarinov on 05.06.2023.
//

import SwiftUI

struct ContactInfoView: View {
    
    @EnvironmentObject var vm: ViewModel
    @State var contact: ContactStruct
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }
    
    var body: some View {
        List {
            customerInfo
            typeSection
            businessSection
            marriageSection
        }
        .scrollIndicators(ScrollIndicatorVisibility.hidden)
        .frame(maxWidth: 550)
        .listStyle(.inset)
        .navigationTitle(contact.name)
    }
}

struct ContactInfoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ContactInfoView(contact: sampleContact)
                .preferredColorScheme(.dark)
        }
        .environmentObject(ViewModel())
        NavigationStack {
            ContactInfoView(contact: sampleContact)
                .preferredColorScheme(.light)
        }
        .environmentObject(ViewModel())
    }
}

extension ContactInfoView {
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
            ForEach(businessArray) { business in
                NavigationLink {
                    BusinessView(business: business)
                } label: {
                    Text("\(business.type.rawValue):\n\(vm.businessSigns(business: business, sign: contact.annualSignStruct.annualSign))")
                        .foregroundColor(.theme.standard)
                }
            }
        } header: {
            Text("Бизнес:")
                .foregroundColor(.theme.accent)
        }
        .listRowSeparator(.hidden)
    }
    
    var marriageSection: some View {
        Section {
            ForEach(marriages) { marriage in
                NavigationLink {
                    MarriageView(marriageStruct: marriage)
                } label: {
                    Text("\(marriage.type.rawValue):\n\(vm.marriageSigns(marriage: marriage, sign: contact.annualSignStruct.annualSign))")
                        .foregroundColor(.theme.standard)
                        .lineSpacing(6)
                }
            }
            Spacer()
                .frame(height: 30)
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
}
