import SwiftUI

struct UserCellView: View {
    
    @EnvironmentObject private var vm: ViewModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.theme.accent, lineWidth: 0.4)
                .frame(maxWidth: .infinity)
                .frame(height: 70)
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
            .padding(.horizontal, 20)
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
