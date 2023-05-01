//
//  SmallVectorRing.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 30.04.2023.
//

import SwiftUI

struct SmallVectorRingView: View {
    
    @EnvironmentObject private var vm: ViewModel
    @State private var showFullDescription = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 40) {
                Text("Малое векторное кольцо")
                    .font(.title)
                    .bold()
                infoSection
                signsSection
            }
        }
        .padding(.horizontal)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SmallVectorRingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SmallVectorRingView()
        }
        .environmentObject(ViewModel())
    }
}

extension SmallVectorRingView {
    var infoSection: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("О малом векторном кольце")
                .bold()
            Text(smallRingText)
                .foregroundColor(.secondary)
                .lineLimit(showFullDescription ? nil : 2)
            Button {
                showFullDescription.toggle()
            } label: {
                Text(showFullDescription ? "Свернуть" : "Развернуть...")
                    .font(.caption)
                    .fontWeight(.bold)
            }
            .accentColor(.blue)
        }
    }
    var signsSection: some View {
        VStack {
            HStack {
                Text("Хозяин")
                    .font(.title)
                    .bold()
                    .frame(width: 170, alignment: .leading)
                Text("Слуга")
                    .font(.title)
                    .bold()
                    .frame(width: 170, alignment: .leading)
                Divider()
            }
            ForEach(ZodiacEnum.allCases, id: \.self) { sign in
                VStack {
                    HStack {
                        Text(sign.rawValue)
                            .font(.title)
                            .frame(width: 170, alignment: .leading)
                        Text(smallRing[sign]!.rawValue)
                            .font(.title)
                            .frame(width: 170, alignment: .leading)
                    }
                }
            }
        }
    }
}
