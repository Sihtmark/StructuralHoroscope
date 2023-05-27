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
            Image("\(vm.mainUser.annualSignStruct.annualSign)Circle")
                .resizable()
                .scaledToFit()
                .frame(width: 55)
                .padding(.trailing,12)
            VStack(alignment: .leading, spacing: 3) {
                Text(vm.mainUser.name)
                    .foregroundColor(.theme.accent)
                    .bold()
                HStack {
                    Text("\(vm.mainUser.annualSignStruct.annualSign.rawValue), \(vm.mainUser.zodiacSign.rawValue.lowercased()), \(vm.mainUser.annualSignStruct.virtualSigns[vm.mainUser.zodiacSign]!.virtualSign.rawValue.lowercased())")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.theme.secondaryText)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            if let actualDayType = vm.actualDayType {
                Text(actualDayType.signs[vm.mainUser.annualSignStruct.annualSign]!.emoji)
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
