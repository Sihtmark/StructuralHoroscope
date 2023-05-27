//
//  CreateCustomerView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 21.04.2023.
//

import SwiftUI

struct CreateCustomerView: View {
    
    @EnvironmentObject private var vm: ViewModel
    @State private var name = ""
    @State private var selectedDate = Date()
    @State private var sex: Sex = .male
    @Environment(\.dismiss) var dismiss
    @State private var annualSign: AnnualEnum = .snake
    @State private var zodiacSign: ZodiacEnum = .taurus
    
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
                    vm.createNewCustomer(name: name, sex: sex, birthday: selectedDate, sign: vm.getAnnualSign(date: selectedDate)!, zodiacSign: vm.getZodiacSign(date: selectedDate)!)
                    dismiss()
                }
            }
        }
    }
}

struct CreateCustomerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CreateCustomerView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(ViewModel())
        NavigationStack {
            CreateCustomerView()
                .preferredColorScheme(.light)
        }
        .environmentObject(ViewModel())
    }
}
