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
    @State private var showFullDescription2 = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 40) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(age.title)
                        .font(.headline)
                    Text(age.text)
                        .foregroundColor(.secondary)
                        .lineLimit(showFullDescription1 ? nil : 2)
                    Button {
                        withAnimation(.easeInOut) {
                            showFullDescription1.toggle()
                        }
                    } label: {
                        Text(showFullDescription1 ? "Свернуть" : "Развернуть...")
                            .font(.caption)
                            .fontWeight(.bold)
                    }
                    .accentColor(.blue)
                }
                Text(age.ageTitle)
                    .font(.headline)
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(age.ageСommandments, id: \.self) { text in
                        Text(text)
                            .foregroundColor(.secondary)
                    }
                }
                    .lineLimit(showFullDescription2 ? nil : 2)
                Button {
                    withAnimation(.easeInOut) {
                        showFullDescription2.toggle()
                    }
                } label: {
                    Text(showFullDescription2 ? "Свернуть" : "Развернуть...")
                        .font(.caption)
                        .fontWeight(.bold)
                }
                .accentColor(.blue)
            }
        }
        .padding(.horizontal)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//struct AgeView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            AgeView(age: )
//        }
//        .environmentObject(ViewModel())
//    }
//}
