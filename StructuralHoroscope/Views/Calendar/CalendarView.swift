//
//  CalendarView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 27.04.2023.
//

import SwiftUI

struct CalendarView: View {
    
    @EnvironmentObject private var vm: ViewModel
    @State private var dateSelected: DateComponents?
    @State private var displayEvents = true
    
    let min = Calendar.current.date(byAdding: .year, value: -2, to: Date())!
    let max = Calendar.current.date(byAdding: .year, value: 2, to: Date())!
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Section {
                    CalendarStruct(
                        interval: DateInterval(start: min, end: max),
                        vm: vm,
                        dateSelected: $dateSelected
                    )
                }
                VStack(alignment: .leading, spacing: 15) {
                    if let dateSelected {
                        let foundEvents = vm.events.filter {$0.date.startOfDay == dateSelected.date!.startOfDay}
                        VStack(alignment: .leading, spacing: 15) {
                            ForEach(foundEvents) { event in
                                ForEach(vm.customers) { client in
                                    HStack {
                                        Text(client.name)
                                            .frame(width: 100, alignment: .leading)
                                        Text(event.signs.signs[client.annualSignStruct.annualSign]!.rawValue)
                                    }
                                }
                                Spacer()
                                    .frame(height: 30)
                                ForEach(AnnualEnum.allCases, id: \.rawValue) { sign in
                                    HStack {
                                        Text(sign.rawValue)
                                            .frame(width: 100, alignment: .leading)
                                        Text(event.signs.signs[sign]!.rawValue)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .onAppear {
                vm.asdf()
            }
            .navigationTitle("Calendar view")
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CalendarView()
        }
        .environmentObject(ViewModel())
    }
}
