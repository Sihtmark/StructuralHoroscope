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
                AnnualSignView(sign: customer.sign)
            } label: {
                HStack {
                    Text("Годовой знак: \(customer.sign.annualSign.rawValue)")
                }
            }
            NavigationLink {
                VirtualSignView(virtualSign: customer.sign.virtualSigns[customer.zodiacSign]!)
            } label: {
                HStack {
                    Text("Виртуальный знак: \(customer.sign.virtualSigns[customer.zodiacSign]!.virtualSign)")
                }
            }
        }
    }
    var typeSection: some View {
        Section("Типы:") {
            NavigationLink {
                IdeologicalView(sign: customer.sign.ideologicalType[customer.sex]!)
            } label: {
                Text("Тип мышления: \((customer.sign.ideologicalType[customer.sex]!.ideologicalType.rawValue))")
            }
            NavigationLink {
                SocialView(social: customer.sign.socialType)
            } label: {
                Text("Социальный тип: \(customer.sign.socialType.socialType.rawValue)")
            }
            NavigationLink {
                PsychologicalView(psychologicalStruct: customer.sign.psychologicalType)
            } label: {
                Text("Психологический тип: \(customer.sign.psychologicalType.psychologicalType.rawValue)")
            }
            NavigationLink {
                EnergyView(energy: customer.sign.temperament)
            } label: {
                Text("Энергетический тип: \(customer.sign.temperament.energyType.rawValue)")
            }
            NavigationLink {
                FateView(fate: customer.sign.fateType)
            } label: {
                Text("Тип судьбы: \(customer.sign.fateType.fateType.rawValue)")
            }
        }
    }
    var vectorSection: some View {
        Section("Векторы:") {
            NavigationLink {
                AnnualSignView(sign: annualSigns[customer.sign.vectorHost]!)
            } label: {
                Text("Хозяин: \(customer.sign.vectorHost.rawValue)")
            }
            NavigationLink {
                AnnualSignView(sign: annualSigns[customer.sign.vectorServant]!)
            } label: {
                Text("Слуга: \(customer.sign.vectorServant.rawValue)")
            }
        }
    }
    var businessSection: some View {
        Section("Бизнес:") {
            NavigationLink {
                BusinessView(business: vectorHost, sign: customer.sign.annualSign)
            } label: {
                Text("Векторный хозяин: \(customer.sign.vectorHost.rawValue)")
            }
            NavigationLink {
                BusinessView(business: vectorServant, sign: customer.sign.annualSign)
            } label: {
                Text("Векторный слуга: \(customer.sign.vectorServant.rawValue)")
            }
            NavigationLink {
                BusinessView(business: clone, sign: customer.sign.annualSign)
            } label: {
                Text("Клоны: \(VM.clones(sign: customer.sign))")
            }
            NavigationLink {
                BusinessView(business: companion, sign: customer.sign.annualSign)
            } label: {
                Text("Соратники: \(VM.companions(sign: customer.sign))")
            }
            NavigationLink {
                BusinessView(business: subordinate, sign: customer.sign.annualSign)
            } label: {
                Text("Подчиненные: \(VM.subordinates(sign: customer.sign))")
            }
            NavigationLink {
                BusinessView(business: subordinate, sign: customer.sign.annualSign)
            } label: {
                Text("Советники: \(VM.advisers(sign: customer.sign))")
            }
        }
    }
    var marriageSection: some View {
        Section("Браки:") {
            NavigationLink {
                MarriageView(marriage: vectorMarriage, sign: customer.sign.annualSign)
            } label: {
                Text("Векторный брак: \(VM.vectorMarriage(sign: customer.sign))")
            }
            NavigationLink {
                MarriageView(marriage: romanticMarriage, sign: customer.sign.annualSign)
            } label: {
                Text("Романтический брак: \(VM.romanticMarriage(sign: customer.sign))")
            }
            NavigationLink {
                MarriageView(marriage: patriarchalMarriage, sign: customer.sign.annualSign)
            } label: {
                Text("Патриархальный брак: \(VM.patriarchalMarriage(sign: customer.sign))")
            }
            NavigationLink {
                MarriageView(marriage: spiritualMarriage, sign: customer.sign.annualSign)
            } label: {
                Text("Духовный брак: \(VM.spiritualMarriage(sign: customer.sign))")
            }
            NavigationLink {
                MarriageView(marriage: equalMarriage, sign: customer.sign.annualSign)
            } label: {
                Text("Равный брак: \(VM.equalMarriage(sign: customer.sign))")
            }
        }
    }
}
