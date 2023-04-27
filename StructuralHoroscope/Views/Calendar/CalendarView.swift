//
//  CalendarView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 27.04.2023.
//

import SwiftUI

struct CalendarView: View {
    
    @EnvironmentObject private var vm: ViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
            .environmentObject(ViewModel())
    }
}
