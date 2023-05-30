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
        VStack(alignment: .leading, spacing: 30) {
            TextField("Имя пользователя", text: $name)
                .foregroundColor(.theme.standard)
                .textFieldStyle(.roundedBorder)
            Picker(selection: $sex) {
                Text("Мужчина").tag(Sex.male)
                Text("Женщина").tag(Sex.female)
            } label: {
                Text("Picker")
            }
            .pickerStyle(.segmented)
            DatePicker("День рождения:", selection: $selectedDate, in: dateRange, displayedComponents: .date)
                .environment(\.locale, Locale.init(identifier: "ru"))
                .foregroundColor(.theme.standard)
            Spacer()
        }
        .frame(maxWidth: 550)
        .padding()
        .navigationTitle("Новый пользователь")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Сохранить") {
                    vm.createNewCustomer(name: name, sex: sex, birthday: selectedDate, sign: vm.getAnnualSign(date: selectedDate)!, zodiacSign: vm.getZodiacSign(date: selectedDate)!)
                    dismiss()
                }
                .disabled(name.count < 3)
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
