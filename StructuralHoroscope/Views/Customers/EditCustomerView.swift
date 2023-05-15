//
//  EditCustomerView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 25.04.2023.
//

import SwiftUI

struct EditCustomerView: View {
    
    @EnvironmentObject private var vm: ViewModel
    var customer: ClientStruct
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var selectedDate = Date()
    @State private var sex: Sex = .male
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            TextField("Имя пользователя", text: $name)
                .textFieldStyle(.roundedBorder)
            Picker(selection: $sex) {
                Text("Мужчина").tag(Sex.male)
                Text("Женщина").tag(Sex.female)
            } label: {
                Text("Picker")
            }
            .pickerStyle(.segmented)
            DatePicker("День рождения:", selection: $selectedDate, displayedComponents: .date)
                .environment(\.locale, Locale.init(identifier: "ru"))
            Spacer()
        }
        .padding()
        .navigationTitle("Новый пользователь")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Сохранить") {
                    vm.updateCustomer(client: customer, name: name, sex: sex, birthday: selectedDate, sign: vm.getAnnualSign(date: selectedDate)!, zodiacSign: vm.getZodiacSign(date: selectedDate)!)
                    dismiss()
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

struct EditCustomerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            EditCustomerView(customer: sampleClient)
        }
        .environmentObject(ViewModel())
    }
}

