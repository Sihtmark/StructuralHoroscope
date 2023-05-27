//
//  StartingView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 09.05.2023.
//

import SwiftUI

struct StartingView: View {
    
    @EnvironmentObject private var vm: ViewModel
    @State private var name = ""
    @State private var selectedDate = Date()
    @State private var sex: Sex = .male
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text("Новый пользователь")
                .font(.largeTitle)
            TextField("Введите ваше имя", text: $name)
                .textFieldStyle(.roundedBorder)
            HStack {
                Text("Пол:")
                    .padding(.trailing, 30)
                Picker(selection: $sex) {
                    Text("Мужской").tag(Sex.male)
                    Text("Женский").tag(Sex.female)
                } label: {
                    Text("Пол")
                        .foregroundColor(.theme.accent)
                }
                .pickerStyle(.segmented)
            }
            DatePicker("Дата рождения:", selection: $selectedDate, displayedComponents: .date)
            NavigationLink {
                MainTabView()
            } label: {
                Text("Сохранить")
                    .foregroundColor(.theme.accent)
            }
            .onTapGesture {
                vm.updateMainUser(name: name, sex: sex, birthday: selectedDate, sign: vm.getAnnualSign(date: selectedDate)!, zodiacSign: vm.getZodiacSign(date: selectedDate)!)
                print(vm.mainUser.zodiacSign.rawValue)
            }
            Spacer()
        }
        .padding()
    }
}

struct StartingView_Previews: PreviewProvider {
    static var previews: some View {
        StartingView()
    }
}
