//
//  StructuralHoroscopeApp.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 31.03.2023.
//

import SwiftUI

@main
struct StructuralHoroscopeApp: App {
    
    @StateObject private var VM = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView(customer: sampleClient)
            }
            .environmentObject(VM)
        }
    }
}
