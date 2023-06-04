import SwiftUI

struct UserCellView: View {
    
    @EnvironmentObject private var vm: ViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("Мой профиль")
                    .foregroundColor(.theme.standard)
                    .bold()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            if let actualDayType = vm.actualDayType {
                Text("\(actualDayType.signs[vm.user!.annualSignStruct.annualSign]!.emoji)")
                    .foregroundColor(.theme.secondaryText)
            }
        }
    }
}

struct MainCustomerCellView_Previews: PreviewProvider {
    static var previews: some View {
        UserCellView()
            .environmentObject(ViewModel())
            .preferredColorScheme(.dark)
        UserCellView()
            .environmentObject(ViewModel())
            .preferredColorScheme(.light)
    }
}
