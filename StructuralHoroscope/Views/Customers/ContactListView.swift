import SwiftUI

struct ContactListView: View {
    
    @EnvironmentObject private var vm: ViewModel
    @State private var isAdding: ContactStruct?
    @State private var date = Date()
    @State private var feeling = Feelings.notTooBad
    @State private var describe = ""
    @State private var filter: FilterMainView = .standardOrder
    @State private var showAlert = false
    
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
                ForEach(vm.listOrder(order: filter)) { customer in
                    ZStack(alignment: .leading) {
                        ContactCellView(contact: customer)
                        NavigationLink {
                            if customer.contact != nil {
                                ContactView(contact: customer)
                            } else {
                                ContactInfoView(contact: customer)
                            }
                        } label: {
                            EmptyView()
                        }
                        .opacity(0.0)
                    }
                    .listRowSeparator(.hidden)
                    .swipeActions(edge: .leading, allowsFullSwipe: true) {
                        if customer.contact != nil {
                            Button {
                                isAdding = customer
                            } label: {
                                Label("Общение", systemImage: "checkmark.square")
                            }
                            .tint(.green)
                        }
                    }
                    .listRowSeparator(.hidden)
                }
                .onDelete(perform: vm.deleteContact)
                .onMove(perform: vm.moveContact)
            }
            .scrollIndicators(ScrollIndicatorVisibility.hidden)
            .frame(maxWidth: 550)
            .listStyle(.inset)
            .navigationTitle("Контакты")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        CalendarView()
                    } label: {
                        Image(systemName: "calendar")
                    }

                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        InfoView()
                    } label: {
                        Image(systemName: "list.clipboard")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAlert.toggle()
                    } label: {
                        Image(systemName: "slider.vertical.3")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        AddNewContactView()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .alert("Фильтр контактов", isPresented: $showAlert, actions: {
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
            })
            .sheet(item: $isAdding) { contact in
                sheetView
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
    var sheetView: some View {
        VStack {
            HStack {
                Button {
                    isAdding = nil
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
                            vm.addMeeting(contact: isAdding!, date: date, feeling: feeling, describe: describe)
                            isAdding!.contact!.lastContact = isAdding!.contact!.allEvents.map{$0.date}.max()!
                            if let i = vm.contacts.firstIndex(where: {$0.id == isAdding!.id}) {
                                vm.contacts[i].contact!.lastContact = isAdding!.contact!.allEvents.map{$0.date}.max()!
                            }
                            isAdding = nil
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
