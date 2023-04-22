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
    @State private var picker: Sex = .male
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            TextField("Имя пользователя", text: $name)
                .textFieldStyle(.roundedBorder)
            Picker(selection: $picker) {
                Text("Мужчина").tag(Sex.male)
                Text("Женщина").tag(Sex.female)
            } label: {
                Text("Picker")
        }
            .pickerStyle(.segmented)
            DatePicker("День рождения:", selection: $selectedDate, displayedComponents: .date)
            Button("Сохранить") {
                vm.createNewCustomer(name: name, sex: picker, birthday: selectedDate)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Новый пользователь")
    }
}

struct CreateCustomerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CreateCustomerView()
        }
        .environmentObject(ViewModel())
    }
}
