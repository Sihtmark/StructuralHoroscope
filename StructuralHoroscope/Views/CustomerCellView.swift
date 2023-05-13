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
                    Text("\(customer.zodiacSign.rawValue), \(customer.annualSignStruct.virtualSigns[customer.zodiacSign]!.virtualSign.lowercased())")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Text("Ваш \(vm.ourBusinessRelationship(customer: customer).rawValue.lowercased())")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Image("\(customer.zodiacSign)Circle")
                .resizable()
                .scaledToFit()
                .frame(width: 35)
                .padding(.leading, 12)
                .padding(.trailing, 10)
        }
    }
}

struct CustomerCellView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerCellView(customer: sampleClient)
            .environmentObject(ViewModel())
    }
}
