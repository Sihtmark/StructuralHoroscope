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
    
    @AppStorage("isDarkMode") var isDarkMode: Bool = true
    @StateObject private var vm = ViewModel()
    
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

