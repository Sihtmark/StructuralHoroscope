//
//  ContentView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 31.03.2023.
//

import SwiftUI

struct CustomerView: View {
    
    @EnvironmentObject var VM: ViewModel
    @State var customer: ClientStruct
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }
    
    var body: some View {
        List {
            customerInfo
            signSection
            typeSection
            vectorSection
            businessSection
            marriageSection
        }
        .listStyle(.grouped)
        .navigationTitle(customer.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    EditCustomerView(customer: customer)
                } label: {
                    Text("Изменить")
                }
            }
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
        Section {
            Text(customer.name)
            Text(customer.sex == .male ? "Пол: мужской" : "Пол: женский")
            Text("День рождения: \(dateFormatter.string(from: customer.birthday))")
        }
    }
    var signSection: some View {
        Section("Знаки:") {
            Text("Знак Зодиака: \(customer.zodiacSign.rawValue)")
            NavigationLink {
                AnnualSignView(sign: customer.annualSignStruct)
            } label: {
                HStack {
                    Text("Годовой знак: \(customer.annualSignStruct.annualSign.rawValue)")
                }
            }
            NavigationLink {
                VirtualSignView(virtualSign: customer.annualSignStruct.virtualSigns[customer.zodiacSign]!)
            } label: {
                HStack {
                    Text("Виртуальный знак: \(customer.annualSignStruct.virtualSigns[customer.zodiacSign]!.virtualSign)")
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
                Text("Энергетический тип: \(customer.annualSignStruct.temperament.energyType.rawValue)")
            }
            NavigationLink {
                FateView(fate: customer.annualSignStruct.fateType)
            } label: {
                Text("Тип судьбы: \(customer.annualSignStruct.fateType.fateType.rawValue)")
            }
        }
    }
    var vectorSection: some View {
        Section("Векторы:") {
            NavigationLink {
                AnnualSignView(sign: annualSigns[customer.annualSignStruct.vectorHost]!)
            } label: {
                Text("Хозяин: \(customer.annualSignStruct.vectorHost.rawValue)")
            }
            NavigationLink {
                AnnualSignView(sign: annualSigns[customer.annualSignStruct.vectorServant]!)
            } label: {
                Text("Слуга: \(customer.annualSignStruct.vectorServant.rawValue)")
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
                Text("Клоны: \(VM.clones(sign: customer.annualSignStruct))")
            }
            NavigationLink {
                BusinessView(business: companion, sign: customer.annualSignStruct.annualSign)
            } label: {
                Text("Соратники: \(VM.companions(sign: customer.annualSignStruct))")
            }
            NavigationLink {
                BusinessView(business: subordinate, sign: customer.annualSignStruct.annualSign)
            } label: {
                Text("Подчиненные: \(VM.subordinates(sign: customer.annualSignStruct))")
            }
            NavigationLink {
                BusinessView(business: subordinate, sign: customer.annualSignStruct.annualSign)
            } label: {
                Text("Советники: \(VM.advisers(sign: customer.annualSignStruct))")
            }
        }
    }
    var marriageSection: some View {
        Section("Браки:") {
            NavigationLink {
                MarriageView(marriage: vectorMarriage, sign: customer.annualSignStruct.annualSign)
            } label: {
                Text("Векторный брак: \(VM.vectorMarriage(sign: customer.annualSignStruct))")
            }
            NavigationLink {
                MarriageView(marriage: romanticMarriage, sign: customer.annualSignStruct.annualSign)
            } label: {
                Text("Романтический брак: \(VM.romanticMarriage(sign: customer.annualSignStruct))")
            }
            NavigationLink {
                MarriageView(marriage: patriarchalMarriage, sign: customer.annualSignStruct.annualSign)
            } label: {
                Text("Патриархальный брак: \(VM.patriarchalMarriage(sign: customer.annualSignStruct))")
            }
            NavigationLink {
                MarriageView(marriage: spiritualMarriage, sign: customer.annualSignStruct.annualSign)
            } label: {
                Text("Духовный брак: \(VM.spiritualMarriage(sign: customer.annualSignStruct))")
            }
            NavigationLink {
                MarriageView(marriage: equalMarriage, sign: customer.annualSignStruct.annualSign)
            } label: {
                Text("Равный брак: \(VM.equalMarriage(sign: customer.annualSignStruct))")
            }
        }
    }
}
