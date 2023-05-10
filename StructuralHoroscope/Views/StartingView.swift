//
//  StartingView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 09.05.2023.
//

import SwiftUI

struct StartingView: View {
    
    @EnvironmentObject private var vm: ViewModel
    @State private var mainClient: ClientStruct? = nil
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
            Picker(selection: $sex) {
                Text("Мужчина").tag(Sex.male)
                Text("Женщина").tag(Sex.female)
            } label: {
                Text("Picker")
            }
            .pickerStyle(.segmented)
            DatePicker("День рождения:", selection: $selectedDate, displayedComponents: .date)
            Button("Сохранить") {
                mainClient = ClientStruct(name: name, birthday: selectedDate, sex: sex, annualSignStruct: annualSigns[annualSign]!, zodiacSign: zodiacSign)
                UserDefaults.standard.set(mainClient, forKey: "mainClient")
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
