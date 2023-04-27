//
//  MainTabView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 27.04.2023.
//

import SwiftUI

struct MainTabView: View {
    
    @EnvironmentObject private var vm: ViewModel
    @State private var selection: Tab = .home
    
    var body: some View {
        TabView(selection: $selection) {
            AllCustomersView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Главная")
                }
                .tag(Tab.home)
            InfoView()
                .tabItem {
                    Image(systemName: "list.clipboard")
                    Text("Информация")
                }
                .tag(Tab.info)
            CalendarView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Календарь")
                }
                .tag(Tab.calendar)
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Настройки")
                }
                .tag(Tab.settings)
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MainTabView()
        }
        .environmentObject(ViewModel())
    }
}
