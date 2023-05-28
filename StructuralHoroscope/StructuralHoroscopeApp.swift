//
//  StructuralHoroscopeApp.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 31.03.2023.
//

import SwiftUI

import SwiftUI

@main
struct StructuralHoroscopeApp: App {
    
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    @StateObject private var vm = ViewModel()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
    }
    
    var body: some Scene {
        WindowGroup {
            if vm.mainUser == sampleClient {
                StartingView().environmentObject(vm)
                    .preferredColorScheme(isDarkMode ? .dark : .light)
            } else {
                MainTabView().environmentObject(vm)
                    .preferredColorScheme(isDarkMode ? .dark : .light)
            }
        }
    }
}

