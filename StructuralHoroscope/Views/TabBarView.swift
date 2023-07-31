//
//  TabBarView.swift
//  SmartRelations
//
//  Created by Sergei Poluboiarinov on 23.06.2023.
//

import SwiftUI

struct TabBarView: View {
    
    @EnvironmentObject private var vm: ViewModel
    @State private var selection: Tab = .home
    
    enum Tab {
        case home
        case info
        case calendar
    }
    
    var body: some View {
        TabView(selection: $selection) {
            ContactListView()
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
//            SettingsView()
//                .tabItem {
//                    Image(systemName: "gearshape.fill")
//                    Text("Настройки")
//                }
//                .tag(Tab.settings)
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TabBarView()
        }
        .environmentObject(ViewModel())
    }
}
