//
//  CalendarStruct.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 05.05.2023.
//

import SwiftUI

struct CalendarStruct: UIViewRepresentable {
    
    let interval: DateInterval
    @ObservedObject var vm: ViewModel
    @Binding var dateSelected: DateComponents?
    @Binding var displayEvents: Bool
    
    func makeUIView(context: Context) -> some UICalendarView {
        let view = UICalendarView()
        view.delegate = context.coordinator
        view.calendar = Calendar(identifier: .gregorian)
        view.availableDateRange = interval
        let dateSelection = UICalendarSelectionSingleDate(delegate: context.coordinator)
        view.selectionBehavior = dateSelection
        return view
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self, vm: _vm)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let changedEvent = vm.changedEvent {
            uiView.reloadDecorations(forDateComponents: [changedEvent.dateComponents], animated: true)
            vm.changedEvent = nil
        }
        if let movedEvent = vm.movedEvent {
            uiView.reloadDecorations(forDateComponents: [movedEvent.dateComponents], animated: true)
            vm.movedEvent = nil
        }
    }
    
    class Coordinator: NSObject, UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
        var parent: CalendarStruct
        @ObservedObject var vm: ViewModel
        init(parent: CalendarStruct, vm: ObservedObject<ViewModel>) {
            self.parent = parent
            self._vm = vm
        }
        @MainActor
        func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
            let foundEvents = vm.events.filter {$0.date.startOfDay == dateComponents.date?.startOfDay}
            if foundEvents.isEmpty {return nil}
            let singleEvent = foundEvents.first!
            return .customView {
                let icon = UILabel()
                icon.text = singleEvent.signs[.bull]!.rawValue
                return icon
            }
        }
        func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
            parent.dateSelected = dateComponents
            guard let dateComponents else {return}
            let foundEvents = vm.events.filter {$0.date.startOfDay == dateComponents.date?.startOfDay}
            if !foundEvents.isEmpty {
                parent.displayEvents.toggle()
            }
        }
        func dateSelection(_ selection: UICalendarSelectionSingleDate,
                           canSelectDate dateComponents: DateComponents?) -> Bool {
            return true
        }
    }
}
