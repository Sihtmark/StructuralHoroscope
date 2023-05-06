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
    @State private var displayEvents = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                CalendarStruct(
                    interval: DateInterval(start: .distantPast, end: .distantFuture),
                    vm: vm,
                    dateSelected: $dateSelected,
                    displayEvents: $displayEvents
                )
                CellView(dateInfo: <#T##DayStruct#>)
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
