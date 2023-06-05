import SwiftUI

struct ContactListView: View {
    
    @EnvironmentObject private var vm: ViewModel
    
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
                ForEach(vm.contacts) { customer in
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
                    .swipeActions(edge: .leading, allowsFullSwipe: true) {
                        if customer.contact != nil {
                            Button {
                                vm.updateEvent(contact: customer)
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
            .padding(.horizontal, 10)
            .scrollIndicators(ScrollIndicatorVisibility.hidden)
            .frame(maxWidth: 550)
            .listStyle(.inset)
            .navigationTitle("Контакты")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
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

