import SwiftUI

struct ContactCellView: View {
    
    @EnvironmentObject private var vm: ViewModel
    let contact: ContactStruct
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        return formatter
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 3) {
                Text(contact.name)
                    .bold()
                    .font(.headline)
                    .foregroundColor(.theme.standard)
                HStack {
                    Text("\(vm.returnBusinessSing(sign: vm.ourBusinessRelationship(customer: contact)))")
                        .font(.callout)
                        .foregroundColor(.theme.secondaryText)
                    Spacer()
                    if let contact = contact.contact {
                        Text(vm.daysFromLastEventCell(lastEvent: contact.lastContact))
                            .foregroundColor(vm.getNextEventDate(component: contact.component, lastContact: contact.lastContact, interval: contact.distance) > Date() ? .theme.green : .theme.red)
                            .font(.caption)
                            .bold()
                            .padding(.trailing)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            if let actualDayType = vm.actualDayType {
                Text(actualDayType.signs[contact.annualSignStruct.annualSign]!.emoji)
            }
        }
    }
}

struct CustomerCellView_Previews: PreviewProvider {
    static var previews: some View {
        ContactCellView(contact: sampleContact)
            .environmentObject(ViewModel())
            .preferredColorScheme(.dark)
        ContactCellView(contact: sampleContact)
            .environmentObject(ViewModel())
            .preferredColorScheme(.light)
    }
}
