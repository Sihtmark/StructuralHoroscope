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
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        return formatter
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 3) {
                Text(customer.name)
                    .bold()
                    .font(.headline)
                    .foregroundColor(.theme.standard)
                HStack {
                    Text("\(vm.returnBusinessSing(sign: vm.ourBusinessRelationship(customer: customer)))")
                        .font(.callout)
                        .foregroundColor(.theme.secondaryText)
                    Spacer()
                    if let contact = customer.contact {
                        Text("Общались \(dateFormatter.string(from: contact.lastContact))")
                            .foregroundColor(vm.getNextContactDate(component: contact.component, lastContact: contact.lastContact, interval: contact.distance) > Date() ? .theme.green : .theme.red)
                            .font(.caption)
                            .bold()
                            .padding(.trailing)
                    }
                }
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
