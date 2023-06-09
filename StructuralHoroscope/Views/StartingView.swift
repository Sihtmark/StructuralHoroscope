import SwiftUI

struct StartingView: View {
    
    @EnvironmentObject private var vm: ViewModel
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
            Text("Новый пользователь")
                .foregroundColor(.theme.standard)
                .font(.largeTitle)
            HStack {
                Text("Пол:")
                    .padding(.trailing, 30)
                    .foregroundColor(.theme.standard)
                Picker(selection: $sex) {
                    Text("Мужской").tag(Sex.male)
                    Text("Женский").tag(Sex.female)
                } label: {
                    Text("Пол")
                }
                .pickerStyle(.segmented)
            }
            VStack(spacing: -10) {
                Text("Дата рождения")
                    .foregroundColor(.theme.standard)
                    .padding(.bottom, 15)
                HStack {
                    Spacer()
                    DatePicker(selection: $selectedDate, in: dateRange, displayedComponents: .date) {}
                        .foregroundColor(.theme.accent)
                        .datePickerStyle(.wheel)
                        .frame(width: 320, height: 180)
                        .padding(.trailing, 7.5)
                        .overlay(alignment: .bottom) {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.gray.opacity(0.2))
                                .allowsHitTesting(false)
                    }
                    Spacer()
                }
            }
            HStack {
                Spacer()
                NavigationLink {
                    ContactListView()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.gray.opacity(0.25))
                            .frame(width: 150, height: 60)
                        Text("Сохранить")
                            .foregroundColor(.theme.accent)
                            .bold()
                            .padding(10)
                        .padding(.horizontal)
                    }
                }
                .onTapGesture {
                    vm.updateUser(sex: sex, birthday: selectedDate, sign: vm.getAnnualSign(date: selectedDate)!, zodiacSign: vm.getMonth(date: selectedDate)!)
                }
                Spacer()
            }
            Spacer()
        }
        .frame(maxWidth: 550)
        .padding()
        .onDisappear {
            vm.nm.requestAuthorization()
        }
    }
}

struct StartingView_Previews: PreviewProvider {
    static var previews: some View {
        StartingView()
            .environmentObject(ViewModel())
            .preferredColorScheme(.dark)
        StartingView()
            .environmentObject(ViewModel())
            .preferredColorScheme(.light)
    }
}
