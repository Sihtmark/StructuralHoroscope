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
            VStack(alignment: .leading, spacing: 3) {
                Text(vm.mainUser!.name)
                    .foregroundColor(.theme.standard)
                    .bold()
                HStack {
                    Text("\(vm.mainUser!.annualSignStruct.socialSigns[vm.mainUser!.month]!.socialSign.rawValue.lowercased())")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.theme.secondaryText)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            if let actualDayType = vm.actualDayType {
                Text(actualDayType.signs[vm.mainUser!.annualSignStruct.annualSign]!.emoji)
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
