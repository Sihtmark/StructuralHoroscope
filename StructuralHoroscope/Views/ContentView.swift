//
//  ContentView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 31.03.2023.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var VM: ViewModel
    let customer: ClientStruct
    
    var body: some View {
        List {
            signSection
            typeSection
            vectorSection
            businessSection
            marriageSection
        }
        .listStyle(.grouped)
        .navigationTitle("Мой тип")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ContentView(customer: sampleCustomer)
        }
        .environmentObject(ViewModel())
    }
}

extension ContentView {
    var signSection: some View {
        Section("Знаки:") {
            NavigationLink {
                AnnualSignInfo(sign: customer.sign)
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
            Text("Тип мышления: \(customer.sign.ideologicalType[customer.sex]?.rawValue ?? "")")
            Text("Социальный тип: \(customer.sign.socialType.rawValue)")
            Text("Психологический тип: \(customer.sign.psychologicalType.rawValue)")
            Text("Энергетический тип: \(customer.sign.temperament.rawValue)")
            Text("Тип судьбы: \(customer.sign.fateType.rawValue)")
        }
    }
    var vectorSection: some View {
        Section("Векторы:") {
            Text("Хозяин: \(customer.sign.vectorHost.rawValue)")
            Text("Слуга: \(customer.sign.vectorServant.rawValue)")
        }
    }
    var businessSection: some View {
        Section("Бизнес:") {
            Text("Клоны: \(VM.clones(sign: customer.sign))")
            Text("Соратники: \(VM.companions(sign: customer.sign))")
            Text("Подчиненные: \(VM.subordinates(sign: customer.sign))")
            Text("Советники: \(VM.advisers(sign: customer.sign))")
        }
    }
    var marriageSection: some View {
        Section("Браки:") {
            Text("Романтический брак: \(VM.romantic(sign: customer.sign))")
            Text("Патриархальный брак: \(VM.patriarchal(sign: customer.sign))")
            Text("Равный брак: \(VM.equal(sign: customer.sign))")
            Text("Духовный брак: \(VM.spiritual(sign: customer.sign))")
        }
    }
}
