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
                ZStack(alignment: .leading) {
                    MainCustomerCellView()
                    NavigationLink {
                        MainCustomerView()
                    } label: {
                        EmptyView()
                    }
                    .opacity(0.0)
                }
                ForEach(vm.customers) { customer in
                    ZStack(alignment: .leading) {
                        CustomerCellView(customer: customer)
                        NavigationLink {
                            CustomerView(customer: customer)
                        } label: {
                            EmptyView()
                        }
                        .opacity(0.0)
                    }
                    .swipeActions(edge: .leading, allowsFullSwipe: true) {
                        if customer.contact != nil {
                            Button {
                                vm.updateCustomersContact(customer: customer)
                            } label: {
                                Label("Общение", systemImage: "checkmark.square")
                            }
                            .tint(.green)
                        }
                    }
//                    .listRowSeparator(.hidden)
                }
                .onDelete(perform: vm.deleteItem)
                .onMove(perform: vm.moveItem)
            }
            .padding(.horizontal, 10)
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

