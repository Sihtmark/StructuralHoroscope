import SwiftUI

struct ContactView: View {
    
    @EnvironmentObject var vm: ViewModel
    @Environment(\.dismiss) private var dismiss
    @State var contact: ContactStruct
    @State private var isEditing = false
    @State private var name = ""
    @State private var selectedDate = Date()
    @State private var sex: Sex = .male
    @State private var isAdding = false
    @State private var date = Date()
    @State private var feeling = Feelings.notTooBad
    @State private var describe = ""
    @State private var isFavorite = false
    
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
                .padding(.top, 20)
            if contact.contact != nil {
                eventsSection
            }
        }
        .scrollIndicators(ScrollIndicatorVisibility.hidden)
        .frame(maxWidth: 550)
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
        .sheet(isPresented: $isAdding, content: {
            addMeetingSheet
        })
        .onAppear {
            name = contact.name
            selectedDate = contact.birthday
            sex = contact.sex
            isFavorite = contact.isFavorite
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
        VStack(spacing: 15) {
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
            VStack {
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
                ZStack {
                    Button {
                        isFavorite.toggle()
                        vm.toggleFavorite(contact: self.contact)
                    } label: {
                        ZStack {
                            Image(systemName: isFavorite ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                        }
                    }
                    .offset(x: 100)
                    Button {
                        isAdding.toggle()
                    } label: {
                        Label("Добавить", systemImage: "plus")
                    }
                    .buttonStyle(.bordered)
                .padding(.top, 5)
                }
            }
        }
    }
    
    var eventsSection: some View {
        ForEach(contact.contact!.allEvents.sorted(by: {$0.date > $1.date})) { event in
            NavigationLink {
                MeetingView(meeting: event, contact: $contact)
            } label: {
                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.theme.accent, lineWidth: 0.4)
                        .frame(maxWidth: .infinity)
                    VStack(alignment: .leading, spacing: 6) {
                        HStack() {
                            Text(event.feeling.rawValue)
                            Text(dateFormatter.string(from: event.date))
                                .foregroundColor(.theme.accent)
                        }
                        Text(event.describe)
                            .foregroundColor(.theme.secondaryText)
                            .font(.callout)
                            .multilineTextAlignment(.leading)
                    }
                    .padding()
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
            }
        }
    }
    
    var addMeetingSheet: some View {
        VStack {
            HStack {
                Button {
                    isAdding.toggle()
                } label: {
                    Label("Назад", systemImage: "chevron.left")
                }
                Spacer()
            }
            .padding(.top, 20)
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.gray.opacity(0.2))
                            .frame(width: 310, height: 180)
                        DatePicker(selection: $date, in: dateRange, displayedComponents: .date) {}
                            .foregroundColor(.theme.accent)
                            .datePickerStyle(.wheel)
                            .padding(.trailing, 40)
                    }
                    Picker("", selection: $feeling) {
                        ForEach(Feelings.allCases, id: \.self) { feeling in
                            Text(feeling.rawValue).tag(feeling)
                        }
                    }
                    .pickerStyle(.segmented)
                    TextEditor(text: $describe)
                        .frame(height: 200)
                        .foregroundColor(.theme.secondaryText)
                        .padding(10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.gray.opacity(0.2))
                                .allowsHitTesting(false)
                        }
                    HStack {
                        Spacer()
                        Button {
                            vm.addMeeting(contact: contact, date: date, feeling: feeling, describe: describe)
                            contact = contact.addMeeting(contact: contact.contact!, date: date, feeling: feeling, describe: describe)
                            contact.contact!.lastContact = contact.contact!.allEvents.map{$0.date}.max()!
                            if let i = vm.contacts.firstIndex(where: {$0.id == contact.id}) {
                                vm.contacts[i].contact!.lastContact = contact.contact!.allEvents.map{$0.date}.max()!
                            }
                            isAdding.toggle()
                            date = Date()
                            feeling = .notTooBad
                            describe = ""
                        } label: {
                            Text("Сохранить")
                                .bold()
                                .padding(10)
                                .padding(.horizontal)
                        }
                        .buttonStyle(.borderedProminent)
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
        .padding(.horizontal)
    }
}
