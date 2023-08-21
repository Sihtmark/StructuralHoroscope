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
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.theme.accent, lineWidth: 0.4)
                .frame(maxWidth: .infinity)
                .frame(height: 70)
            HStack {
                VStack(alignment: .leading, spacing: 3) {
                    Text(contact.name)
                        .bold()
                        .font(.headline)
                        .foregroundColor(.theme.standard)
                    HStack {
                        Text("\(vm.returnBusinessSing(sign: vm.ourBusinessRelationship(customer: contact)))")
                            .font(.caption)
                            .bold()
                            .foregroundColor(.theme.secondaryText)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                HStack(alignment: .bottom, spacing: 10) {
                    if let contact = contact.contact {
                        Text(vm.daysFromLastEventCell(lastEvent: contact.lastContact, component: contact.component, lastContact: contact.lastContact, Interval: contact.distance))
                            .foregroundColor(vm.getNextEventDate(component: contact.component, lastContact: contact.lastContact, interval: contact.distance) > Date() ? .theme.green : .theme.red)
                            .font(.caption)
                            .bold()
                    }
                    VStack(spacing: 10) {
                        if contact.isFavorite {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        }
                        if let actualDayType = vm.actualDayType {
                            Text(actualDayType.signs[contact.annualSignStruct.annualSign]!.emoji)
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
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
