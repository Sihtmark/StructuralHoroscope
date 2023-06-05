import SwiftUI

struct ContactView: View {
    
    @EnvironmentObject var vm: ViewModel
    @State var contact: ContactStruct
    @State private var isEditing = false
    @State private var name = ""
    @State private var selectedDate = Date()
    @State private var sex: Sex = .male
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }
    
    var dateRange: ClosedRange<Date> {
        var dateComponents = DateComponents()
        dateComponents.year = 1850
        dateComponents.month = 1
        dateComponents.day = 1
        let calendar = Calendar(identifier: .gregorian)
        let min = calendar.date(from: dateComponents)!
        let max = Date()
        return min...max
    }
    
    var body: some View {
        ScrollView {
            titleSection
                .padding(.top, 40)
            if contact.contact != nil {
                eventsSection
            }
        }
        .scrollIndicators(ScrollIndicatorVisibility.hidden)
        .frame(maxWidth: 550)
        .listStyle(.inset)
        //        .navigationTitle(contact.name)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(isEditing ? "Сохранить" : "Изменить") {
                    isEditing.toggle()
                }
                .disabled(name.count < 3)
            }
        }
        .sheet(isPresented: $isEditing, content: {
            ChangeContactView(contact: $contact)
        })
        .onAppear {
            name = contact.name
            selectedDate = contact.birthday
            sex = contact.sex
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ContactView(contact: sampleContact)
                .preferredColorScheme(.dark)
        }
        .environmentObject(ViewModel())
        NavigationStack {
            ContactView(contact: sampleContact)
                .preferredColorScheme(.light)
        }
        .environmentObject(ViewModel())
    }
}

extension ContactView {
    var titleSection: some View {
        VStack(alignment: .center, spacing: 20) {
            NavigationLink {
                ContactInfoView(contact: contact)
            } label: {
                ZStack {
                    Circle()
                        .fill(.white)
                        .frame(width: 80)
                        .shadow(radius: 3)
                    Circle()
                        .fill(Color(uiColor: .secondarySystemFill))
                        .frame(width: 77)
                    Image("\(contact.annualSignStruct.annualSign)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 45)
                }
            }
            VStack(spacing: 5) {
                Text(contact.name)
                    .font(.title)
                    .foregroundColor(.theme.standard)
                Text("\(vm.returnBusinessSing(sign: vm.ourBusinessRelationship(customer: contact)))")
                    .font(.callout)
                    .foregroundColor(.theme.secondaryText)
            }
            if let contact = contact.contact {
                VStack(spacing: 5) {
                    Text("Последнее общение \(dateFormatter.string(from: contact.lastContact))")
                    Text(vm.daysFromLastEvent(lastEvent: contact.lastContact))
                }
                .font(.callout)
                .foregroundColor(vm.getNextEventDate(component: contact.component, lastContact: contact.lastContact, interval: contact.distance) > Date() ? .theme.green : .theme.red)
            }
        }
    }
    
    var eventsSection: some View {
        ForEach(contact.contact!.allEvents.sorted(by: {$0.date > $1.date})) { event in
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.theme.accent, lineWidth: 0.4)
                    .frame(maxWidth: .infinity)
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text(event.feeling.rawValue)
                        Text(dateFormatter.string(from: event.date))
                            .foregroundColor(.theme.accent)
                    }
                    Text(event.describe)
                        .lineLimit(2)
                        .foregroundColor(.theme.secondaryText)
                        .font(.callout)
                }
                .padding()
            }
            .padding(10)
        }
    }
}
