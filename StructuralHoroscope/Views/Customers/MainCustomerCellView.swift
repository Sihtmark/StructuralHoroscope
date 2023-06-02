//
//  MainCustomerCellView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 15.05.2023.
//

import SwiftUI

struct MainCustomerCellView: View {
    
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
                Text("\(actualDayType.signs[vm.mainUser!.annualSignStruct.annualSign]!.emoji)")
                    .foregroundColor(.theme.secondaryText)
            }
        }
    }
}

struct MainCustomerCellView_Previews: PreviewProvider {
    static var previews: some View {
        MainCustomerCellView()
            .environmentObject(ViewModel())
            .preferredColorScheme(.dark)
        MainCustomerCellView()
            .environmentObject(ViewModel())
            .preferredColorScheme(.light)
    }
}
