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
                Picker(selection: $sex) {
                    Text("Мужской").tag(Sex.male)
                    Text("Женский").tag(Sex.female)
                } label: {
                    Text("Пол")
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
                vm.updateUser(sex: sex, birthday: selectedDate, sign: vm.getAnnualSign(date: selectedDate)!, zodiacSign: vm.getMonth(date: selectedDate)!)
            }
            Spacer()
        }
        .frame(maxWidth: 550)
        .padding()
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
