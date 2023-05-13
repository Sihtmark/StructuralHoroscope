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
            .navigationTitle("Мой список")
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
        }
        .environmentObject(ViewModel())
    }
}
