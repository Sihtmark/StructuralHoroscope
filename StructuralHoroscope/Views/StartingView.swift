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
    @State private var annualSign: AnnualEnum = .snake
    @State private var zodiacSign: ZodiacEnum = .taurus
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text("Новый пользователь")
                .font(.largeTitle)
                .bold()
            TextField("Введите ваше имя", text: $name)
                .textFieldStyle(.roundedBorder)
            HStack {
                Text("Ваш годовой знак:")
                Picker(selection: $annualSign) {
                    ForEach(AnnualEnum.allCases, id: \.self) { sign in
                        Text(sign.rawValue).tag(sign)
                    }
                } label: {
                    Text("Picker")
                }
            }
            HStack {
                Text("Ваш знак зодиака:")
                Picker(selection: $zodiacSign) {
                    ForEach(ZodiacEnum.allCases, id: \.self) { sign in
                        Text(sign.rawValue).tag(sign)
                    }
                } label: {
                    Text("Picker")
                }
            }
            HStack {
                Text("Пол:")
                    .padding(.trailing, 30)
                Picker(selection: $sex) {
                    Text("Мужской").tag(Sex.male)
                    Text("Женский").tag(Sex.female)
                } label: {
                    Text("Пол")
                }
            .pickerStyle(.segmented)
            }
            DatePicker("День рождения:", selection: $selectedDate, displayedComponents: .date)
            NavigationLink("Сохранить") {
                MainTabView()
            }
            .onTapGesture {
                vm.updateMainUser(name: name, sex: sex, birthday: selectedDate, sign: annualSign, zodiacSign: zodiacSign)
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
