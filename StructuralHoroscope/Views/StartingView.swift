//
//  StartingView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 09.05.2023.
//

import SwiftUI

struct StartingView: View {
    
    @EnvironmentObject private var vm: ViewModel
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var name = ""
    @State private var selectedDate = Date()
    @State private var sex: Sex = .male
    
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
            HStack {
                Text("Новый пользователь")
                    .font(.largeTitle)
                Spacer()
                Button {
                    isDarkMode.toggle()
                } label: {
                    Image(systemName: isDarkMode ? "sun.max" : "moon.stars")
                }
                .padding(.trailing)
            }
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
            DatePicker("Дата рождения:", selection: $selectedDate, in: dateRange, displayedComponents: .date)
            NavigationLink {
                MainTabView()
            } label: {
                Text("Сохранить")
                    .foregroundColor(.theme.accent)
            }
            .onTapGesture {
                vm.updateMainUser(name: name, sex: sex, birthday: selectedDate, sign: vm.getAnnualSign(date: selectedDate)!, zodiacSign: vm.getZodiacSign(date: selectedDate)!)
            }
            .disabled(name.count < 3)
            Spacer()
        }
        .frame(maxWidth: 550)
        .padding()
    }
}

struct StartingView_Previews: PreviewProvider {
    static var previews: some View {
        StartingView()
    }
}
