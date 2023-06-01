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
    
    @StateObject private var vm = ViewModel()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.standard)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.standard)]
    }
    
    var body: some Scene {
        WindowGroup {
            if vm.mainUser == nil {
                StartingView().environmentObject(vm)
            } else {
                MainTabView().environmentObject(vm)
            }
        }
    }
}

