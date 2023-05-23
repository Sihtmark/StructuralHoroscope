//
//  AllCustomersView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 24.04.2023.
//

import SwiftUI

struct AllCustomersView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    @EnvironmentObject private var vm: ViewModel
    @State private var showAlert = false
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    MainCustomerView()
                } label: {
                    MainCustomerCellView()
                }
                ForEach(vm.customers) { customer in
                    NavigationLink {
                        CustomerView(customer: customer)
                    } label: {
                        CustomerCellView(customer: customer)
                    }
                }
                .onDelete(perform: vm.deleteItem)
                .onMove(perform: vm.moveItem)
            }
            .listStyle(.inset)
            .navigationTitle("Мой список")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Sync") {
                        showAlert.toggle()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isDarkMode.toggle()
                    } label: {
                        Image(systemName: isDarkMode ? "sun.max" : "moon.stars")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        CreateCustomerView()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .alert("Добавить гороскоп в ваш календарь?", isPresented: $showAlert) {
                Button("Добавить") {
                    vm.addAllEventsToCalendar()
                    HapticManager.instance.notification(type: .success)
                }
                Button(role: .cancel) {
                    HapticManager.instance.notification(type: .error)
                } label: {
                    Text("Отменить")
                }

            }
        }
    }
}

struct AllCustomersView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AllCustomersView()
        }
        .environmentObject(ViewModel())
    }
}

