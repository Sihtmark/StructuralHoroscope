import SwiftUI

struct ContactListView: View {
    
    @EnvironmentObject private var vm: ViewModel
    @State private var contactToAddMeeting: ContactStruct?
    @State private var date = Date()
    @State private var feeling = Feelings.notTooBad
    @State private var describe = ""
    @State private var filter: FilterMainView = .standardOrder
    @State private var notifications = false
    @State private var isAddingNewContact = false
    
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
        NavigationStack {
            List {
                myProfile
                if vm.contacts.count == 0 {
                    emptyList
                }
                contactsList
            }
            .navigationDestination(for: ContactStruct.self) { contact in
                MainContactView(contact: contact)
            }
            .scrollIndicators(ScrollIndicatorVisibility.hidden)
            .frame(maxWidth: 550)
            .listStyle(.inset)
            .navigationTitle("Контакты")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu(content: {
                        Button("Все по алфавиту") {
                            filter = .alphabeticalOrder
                        }
                        Button("По дате общения") {
                            filter = .dueDateOrder
                        }
                        Button("Только избранные") {
                            filter = .favoritesOrder
                        }
                        Button("Без отслеживания") {
                            filter = .withoutTracker
                        }
                        Button("Без фильтра", role: .destructive) {
                            filter = .standardOrder
                        }
                    }, label: {
                        Image(systemName: "slider.vertical.3")
                    })
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isAddingNewContact.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(item: $contactToAddMeeting) { contact in
                AddMeetingView(contact: contact)
                    .presentationDragIndicator(.visible)
                    .presentationDetents([.fraction(0.7), .large])
            }
            .sheet(isPresented: $isAddingNewContact) {
                AddNewContactView()
                    .presentationDragIndicator(.visible)
            }
        }
    }
}

struct AllCustomersView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ContactListView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(ViewModel())
        NavigationStack {
            ContactListView()
                .preferredColorScheme(.light)
        }
        .environmentObject(ViewModel())
    }
}

extension ContactListView {
    
    var myProfile: some View {
        Section {
            ZStack(alignment: .leading) {
                UserCellView()
                NavigationLink {
                    UserView()
                } label: {
                    EmptyView()
                }
                .opacity(0.0)
            }
            .listRowSeparator(.hidden)
        }
    }
    
    var emptyList: some View {
        Text("В вашем списке пока-что нет ни одного контакта 🧐\n\nНажмите '+' в правом верхнем углу, чтобы добавить ваш первый контакт.")
            .frame(maxWidth: 550, alignment: .center)
            .multilineTextAlignment(.center)
            .font(.title3)
            .foregroundColor(.theme.secondaryText)
            .padding(.top, 40)
    }
    
    var contactsList: some View {
        ForEach(vm.listOrder(order: filter)) { customer in
            ZStack(alignment: .leading) {
                ContactCellView(contact: customer)
                NavigationLink(value: customer) {
                    EmptyView()
                }
                .opacity(0.0)
            }
            .listRowSeparator(.hidden)
            .swipeActions(edge: .leading, allowsFullSwipe: false) {
                if customer.contact != nil {
                    Button {
                        contactToAddMeeting = customer
                    } label: {
                        Label("Контакт", systemImage: "person.fill.checkmark")
                    }
                    .tint(.green)
                }
            }
            .swipeActions(edge: .leading, allowsFullSwipe: false, content: {
                Button {
                    if let index = vm.contacts.firstIndex(where: {$0.id == customer.id}) {
                        vm.contacts[index].isFavorite.toggle()
                    }
                } label: {
                    Label(customer.isFavorite ? "Убрать" : "Добавить", systemImage: customer.isFavorite ? "star.slash" : "star.fill")
                }
                .tint(.yellow)
            })
            .listRowSeparator(.hidden)
        }
        .onDelete(perform: vm.deleteContact)
        .onMove(perform: vm.moveContact)
    }
    
}
