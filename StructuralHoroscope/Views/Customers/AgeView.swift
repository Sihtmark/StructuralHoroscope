//
//  AgeView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 01.05.2023.
//

import SwiftUI

struct AgeView: View {
    
    let age: AgeStruct
    @EnvironmentObject private var VM: ViewModel
    @State private var showFullDescription1 = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 40) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(age.title)
                        .font(.headline)
                    Text(age.text)
                        .foregroundColor(.theme.secondaryText)
                        .lineLimit(showFullDescription1 ? nil : 2)
                    Button {
                        withAnimation(.easeInOut) {
                            showFullDescription1.toggle()
                        }
                    } label: {
                        Text(showFullDescription1 ? "Свернуть" : "Развернуть...")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.theme.accent)
                    }
                    .accentColor(.blue)
                }
                
                VStack(alignment: .leading, spacing: 20) {
                    Text(age.ageTitle)
                        .font(.headline)
                    Text(age.ageСommandments)
                        .foregroundColor(.theme.secondaryText)
                }
            }
        }
        .padding(.horizontal)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AgeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AgeView(age: bullAge)
                .preferredColorScheme(.dark)
        }
        .environmentObject(ViewModel())
        NavigationStack {
            AgeView(age: bullAge)
                .preferredColorScheme(.light)
        }
        .environmentObject(ViewModel())
    }
}
