import SwiftUI

@main
struct StructuralHoroscopeApp: App {
    
    @StateObject private var vm = ViewModel()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.standard)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.standard)]
    }
    
    var body: some Scene {
        WindowGroup {
            if vm.user == nil {
                StartingView().environmentObject(vm)
            } else {
                ContactListView().environmentObject(vm)
            }
        }
    }
}

