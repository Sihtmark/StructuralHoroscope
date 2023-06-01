//
//  AllCustomersView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 24.04.2023.
//

import SwiftUI

struct AllCustomersView: View {
    
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
            .scrollIndicators(ScrollIndicatorVisibility.hidden)
            .frame(maxWidth: 550)
            .listStyle(.inset)
            .navigationTitle("Мой список")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
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

