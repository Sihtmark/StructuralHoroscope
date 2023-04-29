//
//  AnnualSignsView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 29.04.2023.
//

import SwiftUI

struct AnnualSignsView: View {
    
    @EnvironmentObject private var VM: ViewModel
    @State private var showFullDescription = false
    
    var body: some View {
        List {
            ForEach(annualSignArray) { sign in
                NavigationLink {
                    AnnualSignView(sign: sign)
                } label: {
                    Text(sign.annualSign.rawValue)
                }
            }
        }
        .navigationTitle("Годовые знаки")
    }
}

struct AnnualSignsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AnnualSignsView()
        }
        .environmentObject(ViewModel())
    }
}
