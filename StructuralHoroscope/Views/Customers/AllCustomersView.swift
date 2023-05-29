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
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    MainCustomerView()
                } label: {
                    MainCustomerCellView()
                }
                .listRowSeparator(.hidden)
                ForEach(vm.customers) { customer in
                    NavigationLink {
                        CustomerView(customer: customer)
                    } label: {
                        CustomerCellView(customer: customer)
                    }
                    .listRowSeparator(.hidden)
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
        }
    }
}

struct AllCustomersView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AllCustomersView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(ViewModel())
        NavigationStack {
            AllCustomersView()
                .preferredColorScheme(.light)
        }
        .environmentObject(ViewModel())
    }
}

