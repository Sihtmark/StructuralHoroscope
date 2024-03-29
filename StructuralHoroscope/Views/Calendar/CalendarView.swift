import SwiftUI

struct CalendarView: View {
    @EnvironmentObject private var vm: ViewModel
    @State private var events = [DayStruct]()
    @State private var pickedDate = Date()
    @State private var day = Date()
    @State private var showSyncAlert = false
    @State private var list: Bool = true
    @State private var filter: FilterMainView = .standardOrder
    @State private var showFilterAlert = false
    
    var body: some View {
        NavigationStack {
            VStack {
                datePicker
                week
                if !events.isEmpty {
                    signDayType
                }
            }
            .frame(maxWidth: 550)
            .navigationTitle("Календарь")
            .padding(.horizontal)
            .onAppear {
                events = vm.eventsByPickedDate(pickedDate: day)
            }
            .onChange(of: pickedDate) { newValue in
                events = vm.eventsByPickedDate(pickedDate: newValue)
                day = newValue
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showSyncAlert.toggle()
                    } label: {
                        Image(systemName: "arrow.triangle.2.circlepath.circle")
                    }
                }
                if list {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu(content: {
                            Button("Все по алфавиту") {
                                filter = .alphabeticalOrder
                            }
                            Button("По дате общения") {
                                filter = .dueDateOrder
                            }
                            Button("Только избранные") {
                                filter = .favoritesOrder
                            }
                            Button("Без отслеживания") {
                                filter = .withoutTracker
                            }
                            Button("Без фильтра", role: .destructive) {
                                filter = .standardOrder
                            }
                        }, label: {
                            Image(systemName: "slider.vertical.3")
                        })
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        list.toggle()
                    } label: {
                        Text(list ? "Знаки" : "Контакты")
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
            .alert("Добавить гороскоп в ваш календарь?", isPresented: $showSyncAlert) {
                Button("Добавить") {
                    Task {
                        await vm.addAllEventsToCalendar()
                        HapticManager.instance.notification(type: .success)
                    }
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
            DatePicker("Выбрать дату:", selection: $pickedDate, in: DateManager.instance.calendarDateRange, displayedComponents: .date)
                .environment(\.locale, Locale(identifier: "ru"))
                .foregroundColor(.theme.standard)
            Button {
                pickedDate = Date()
                day = Date()
            } label: {
                Image(systemName: "arrowshape.turn.up.backward.circle.fill")
                    .scaleEffect(1.5)
            }
            .padding(.leading, 20)
        }
        .padding(.horizontal, 15)
        .padding(.top, 30)
        .padding(.bottom)
    }
    
    var week: some View {
        HStack(spacing: 10) {
            ForEach(events) { event in
                
                VStack(spacing: 10) {
                    Text(vm.extractDate(date: event.date, format: "dd"))
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                    Text(vm.extractDate(date: event.date, format: "EEE"))
                        .environment(\.locale, Locale(identifier: "ru"))
                        .font(.system(size: 14))
                    Text(event.signs[vm.user!.annualSignStruct.annualSign]!.emoji)
                        .font(.caption)
                }
                .foregroundColor(vm.isToday(date: event.date, pickedDate: day) ? .white : .theme.secondaryText)
                .frame(width: 45, height: 90)
                .background(
                    ZStack {
                        if vm.isToday(date: event.date, pickedDate: day) {
                            Capsule()
                                .fill(Color.theme.accent)
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
            if list {
                ForEach(vm.listOrder(order: filter)) { customer in
                    if events.contains(where: { event in
                        event.date == day
                    }) {
                        HStack {
                            Image("\(customer.annualSignStruct.annualSign)Circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                            Text(customer.name)
                                .foregroundColor(.theme.standard)
                                .bold()
                                .frame(alignment: .leading)
                            Spacer()
                            Text(events.first(where: { $0.date == day })!.signs[customer.annualSignStruct.annualSign]!.title)
                                .foregroundColor(.theme.standard)
                                .frame(alignment: .trailing)
                                .padding(.trailing, 10)
                            Text(events.first(where: { $0.date == day })!.signs[customer.annualSignStruct.annualSign]!.emoji)
                        }
                    } else {
                        HStack {
                            Image("\(customer.annualSignStruct.annualSign)Circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .padding(.trailing, 5)
                            Text(customer.name)
                                .foregroundColor(.theme.standard)
                                .bold()
                                .frame(alignment: .leading)
                            Spacer()
                            Text(events[3].signs[customer.annualSignStruct.annualSign]!.title)
                                .foregroundColor(.theme.standard)
                                .frame(alignment: .trailing)
                                .padding(.trailing, 5)
                            Text(events[3].signs[customer.annualSignStruct.annualSign]!.emoji)
                        }
                    }
                }
                .listRowSeparator(.hidden)
            } else {
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
                            Spacer()
                            Text(events.first(where: { $0.date == day })!.signs[sign]!.title)
                            Text(events.first(where: { $0.date == day })!.signs[sign]!.emoji)
                        }
                    } else {
                        HStack {
                            Image("\(sign)Circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                            Text(sign.rawValue)
                                .foregroundColor(.theme.standard)
                                .bold()
                                .padding(.leading, 20)
                                .frame(width: 110, alignment: .leading)
                            Spacer()
                            Text(events[3].signs[sign]!.title)
                                .foregroundColor(.theme.standard)
                            Text(events[3].signs[sign]!.emoji)
                        }
                    }
                }
                .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .scrollIndicators(ScrollIndicatorVisibility.hidden)
    }
}
