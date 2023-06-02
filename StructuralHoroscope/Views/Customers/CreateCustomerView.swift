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
    @State private var lastMeeting = Date()
    @State private var meetingTracker = true
    @State private var component = Components.week
    @State private var distance = 2
    @State private var reminder = true
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }
    
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
            mainSection
            if meetingTracker {
                meetingTrackerSection
            }
            saveButton
            Spacer()
        }
        .frame(maxWidth: 550)
        .padding()
        .navigationTitle("Новый пользователь")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                
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

extension CreateCustomerView {
    var mainSection: some View {
        VStack(alignment: .leading, spacing: 30) {
            TextField("Имя", text: $name)
                .foregroundColor(.theme.standard)
                .textFieldStyle(.roundedBorder)
                .autocorrectionDisabled()
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
            Toggle("Следить как часто общаетесь?", isOn: $meetingTracker)
                .foregroundColor(.theme.standard)
        }
    }
    var meetingTrackerSection: some View {
        VStack(alignment: .leading, spacing: 30) {
            DatePicker("Последнее ваше общение:", selection: $lastMeeting, in: dateRange, displayedComponents: .date)
                .environment(\.locale, Locale.init(identifier: "ru"))
                .foregroundColor(.theme.standard)
            HStack(spacing: 15) {
                Picker("", selection: $distance) {
                    ForEach(1..<31) { item in
                        Text(String(item)).tag(item)
                    }
                }
                .pickerStyle(.wheel)
                .padding(.horizontal, 5)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color(uiColor: .secondarySystemFill))
                )
                Picker("", selection: $component) {
                    ForEach(Components.allCases, id: \.hashValue) { item in
                        Text(item.rawValue).tag(item)
                    }
                }
                .pickerStyle(.wheel)
                .padding(.horizontal, 5)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color(uiColor: .secondarySystemFill))
                )
            }
            .frame(height: 120)
            Toggle("Отправлять напоминание", isOn: $reminder)
                .foregroundColor(.theme.standard)
        }
    }
    var saveButton: some View {
        HStack {
            Spacer()
            Button("Сохранить") {
                vm.createNewCustomer(name: name, sex: sex, birthday: selectedDate, sign: vm.getAnnualSign(date: selectedDate)!, zodiacSign: vm.getZodiacSign(date: selectedDate)!, distance: distance, component: component, lastContact: lastMeeting, reminder: reminder, meetingTracker: meetingTracker)
                dismiss()
            }
            .buttonStyle(.borderedProminent)
        .disabled(name.count < 1)
            Spacer()
        }
    }
}
