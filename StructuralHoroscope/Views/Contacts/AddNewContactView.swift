import SwiftUI

struct AddNewContactView: View {
    
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
    @State private var feeling = Feelings.notTooBad
    @State private var describe = ""
    @State private var isFavorite = false
    
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
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                mainSection
                if meetingTracker {
                    meetingTrackerSection
                }
                saveButton
            }
        }
        .frame(maxWidth: 550)
        .padding()
        .navigationTitle("Новый пользователь")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CreateCustomerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddNewContactView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(ViewModel())
        NavigationStack {
            AddNewContactView()
                .preferredColorScheme(.light)
        }
        .environmentObject(ViewModel())
    }
}

extension AddNewContactView {
    var mainSection: some View {
        VStack(alignment: .leading, spacing: 30) {
            HStack {
                TextField("Имя", text: $name)
                    .foregroundColor(.theme.standard)
                    .textFieldStyle(.roundedBorder)
                .autocorrectionDisabled()
                Button {
                    isFavorite.toggle()
                } label: {
                    ZStack {
                        Image(systemName: isFavorite ? "star.fill" : "star")
                            .foregroundColor(.yellow)
                    }
                }
                .padding(.horizontal, 5)
            }
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
            Toggle("Отслеживать общение", isOn: $meetingTracker)
                .foregroundColor(.theme.standard)
                .padding(.trailing, 5)
        }
    }
    var meetingTrackerSection: some View {
        VStack(alignment: .leading, spacing: 30) {
            DatePicker("Общались последний раз:", selection: $lastMeeting, in: dateRange, displayedComponents: .date)
                .environment(\.locale, Locale.init(identifier: "ru"))
                .foregroundColor(.theme.standard)
            VStack {
                Picker("", selection: $feeling) {
                    ForEach(Feelings.allCases, id: \.self) { feeling in
                        Text(feeling.rawValue).tag(feeling)
                    }
                }
                .pickerStyle(.segmented)
            }
            VStack(alignment: .leading, spacing: 10) {
                Text("Заметки или описание встречи:")
                    .foregroundColor(.theme.standard)
                TextEditor(text: $describe)
                    .frame(height: 100)
                    .foregroundColor(.theme.secondaryText)
                    .padding(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(uiColor: .secondarySystemFill))
                            .allowsHitTesting(false)
                }
            }
            VStack(alignment: .leading, spacing: 10) {
                Text("Как часто хотите общаться:")
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
            }
            VStack {
                Toggle("Напоминание когда придет время снова общаться с этим контактом", isOn: $reminder)
                    .foregroundColor(.theme.standard)
                .padding(.trailing, 5)
            }
        }
    }
    var saveButton: some View {
        HStack {
            Spacer()
            Button {
                vm.createNewContact(name: name, sex: sex, birthday: selectedDate, sign: vm.getAnnualSign(date: selectedDate)!, zodiacSign: vm.getMonth(date: selectedDate)!, distance: distance, component: component, lastContact: lastMeeting, reminder: reminder, meetingTracker: meetingTracker, feeling: feeling, describe: describe, isFavorite: isFavorite)
                dismiss()
            } label: {
                Text("Сохранить")
                    .bold()
                    .padding(10)
                    .padding(.horizontal)
            }
            .buttonStyle(.borderedProminent)
            .disabled(name.count < 1)
            Spacer()
        }
    }
}
