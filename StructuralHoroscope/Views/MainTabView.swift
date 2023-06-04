import SwiftUI

struct MainTabView: View {
    
    @EnvironmentObject private var vm: ViewModel
    @State private var selection: Tab = .home
    
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
            SettingsView()
                .tabItem {
                    Image(systemName: "circle")
                    Text("Настройки")
                }
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MainTabView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(ViewModel())
        NavigationStack {
            MainTabView()
                .preferredColorScheme(.light)
        }
        .environmentObject(ViewModel())
    }
}
