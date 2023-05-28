//
//  CalendarView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 23.05.2023.
//

import SwiftUI

struct CalendarView: View {
    
    @EnvironmentObject private var vm: ViewModel
    @State private var events = [DayStruct]()
    @State private var pickedDate = Date()
    @State private var day = Date()
    @State private var showAlert = false
    
    var body: some View {
        NavigationStack {
            VStack {
                datePicker
                week
                if !events.isEmpty {
                    signDayType
                }
            }
            .navigationTitle("Календарь")
            .navigationBarTitleDisplayMode(.inline)
            .padding(.horizontal)
            .onAppear {
                events = vm.eventsByPickedDate(pickedDate: day)
            }
            .onChange(of: pickedDate) { newValue in
                events = vm.eventsByPickedDate(pickedDate: newValue)
                day = newValue
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAlert.toggle()
                    } label: {
                        Image(systemName: "arrow.triangle.2.circlepath.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        InfoCalendarView()
                    } label: {
                        Image(systemName: "info.circle")
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

struct NewCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CalendarView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(ViewModel())
        NavigationStack {
            CalendarView()
                .preferredColorScheme(.light)
        }
        .environmentObject(ViewModel())
    }
}

extension CalendarView {
    var datePicker: some View {
        HStack {
            Spacer()
            DatePicker("Выбрать дату:", selection: $pickedDate, displayedComponents: .date)
                .environment(\.locale, Locale.init(identifier: "ru"))
            Spacer()
        }
    }
    
    var week: some View {
        HStack(spacing: 10) {
            ForEach(events) { event in
                
                VStack(spacing: 10) {
                    
                    Text(vm.extractDate(date: event.date, format: "dd"))
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                    Text(vm.extractDate(date: event.date, format: "EEE"))
                        .environment(\.locale, Locale.init(identifier: "ru"))
                        .font(.system(size: 14))
                    Text(event.signs[vm.mainUser.annualSignStruct.annualSign]!.emoji)
                        .font(.caption)
                }
                .foregroundColor(vm.isToday(date: event.date, pickedDate: day) ? .white : .theme.secondaryText)
                .frame(width: 45, height: 90)
                .background(
                    ZStack {
                        if vm.isToday(date: event.date, pickedDate: day) {
                            Capsule()
                                .fill(Color.theme.red)
                        }
                        
                    }
                )
                .contentShape(Capsule())
                .onTapGesture {
                    withAnimation {
                        day = event.date
                    }
                }
            }
        }
    }
    
    var signDayType: some View {
        List {
            ForEach(AnnualEnum.allCases, id: \.self) { sign in
                if events.contains(where: { event in
                    event.date == day
                }) {
                    HStack {
                        Image("\(sign)Circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                        Text(sign.rawValue)
                            .bold()
                            .padding(.leading, 20)
                            .frame(width: 110, alignment: .leading)
                        Text(events.first(where: {$0.date == day})!.signs[sign]!.title)
                        Spacer()
                        Text(events.first(where: {$0.date == day})!.signs[sign]!.emoji)
                            .font(.caption)
                    }
                } else {
                    HStack {
                        Image("\(sign)Circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                        Text(sign.rawValue)
                            .foregroundColor(.theme.red)
                            .bold()
                            .padding(.leading, 20)
                            .frame(width: 110, alignment: .leading)
                        Text(events[3].signs[sign]!.title)
                            .foregroundColor(.theme.red)
                        Spacer()
                        Text(events[3].signs[sign]!.emoji)
                            .font(.caption)
                    }
                }
            }
        }
        .listStyle(.plain)
    }
}
