//
//  CustomerCellView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 13.05.2023.
//

import SwiftUI

struct CustomerCellView: View {
    
    @EnvironmentObject private var vm: ViewModel
    let customer: ClientStruct
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 3) {
                Text(customer.name)
                    .bold()
                    .foregroundColor(.theme.standard)
                HStack {
                    Text(customer.annualSignStruct.virtualSigns[customer.zodiacSign]!.virtualSign.rawValue)
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.theme.secondaryText)
                }
                Text("Мой \(vm.returnBusinessSing(sign: vm.ourBusinessRelationship(customer: customer)).lowercased())")
                    .font(.footnote)
                    .foregroundColor(.theme.green)
                    .bold()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            if let actualDayType = vm.actualDayType {
                Text(actualDayType.signs[customer.annualSignStruct.annualSign]!.emoji)
            }
        }
    }
}

struct CustomerCellView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerCellView(customer: sampleClient)
            .environmentObject(ViewModel())
            .preferredColorScheme(.dark)
        CustomerCellView(customer: sampleClient)
            .environmentObject(ViewModel())
            .preferredColorScheme(.light)
    }
}
