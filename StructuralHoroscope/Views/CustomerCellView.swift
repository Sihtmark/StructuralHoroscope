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
            Image("\(customer.annualSignStruct.annualSign)Circle")
                .resizable()
                .scaledToFit()
                .frame(width: 55)
                .padding(.trailing,12)
            VStack(alignment: .leading, spacing: 3) {
                Text(customer.name)
                    .bold()
                HStack {
                    Text("\(customer.annualSignStruct.annualSign.rawValue), \(customer.zodiacSign.rawValue.lowercased()), \(customer.annualSignStruct.virtualSigns[customer.zodiacSign]!.virtualSign.rawValue.lowercased())")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                Text(vm.returnBusinessSing(sign: vm.ourBusinessRelationship(customer: customer)))
                    .font(.footnote)
                    .foregroundColor(.secondary)
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
    }
}
