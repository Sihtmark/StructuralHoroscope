//
//  SmallVectorRing.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 30.04.2023.
//

import SwiftUI

struct SmallVectorRingView: View {
    
    @EnvironmentObject private var vm: ViewModel
    @State private var showDescription = false
    
    var body: some View {
        ScrollView {
            signsSection
        }
        .padding(.horizontal)
        .navigationTitle("Малое векторное кольцо")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showDescription = true
                } label: {
                    Image(systemName: "info.circle")
                }
            }
        }
        .sheet(isPresented: $showDescription) {
            description
        }
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
    var signsSection: some View {
        VStack(alignment: .center) {
            HStack {
                Text("Хозяин")
                    .font(.title2)
                    .bold()
                .frame(width: 150, height: 40)
                .padding(5)
                Text("Слуга")
                    .font(.title2)
                    .bold()
                .frame(width: 150, height: 40)
                .padding(5)
            }
            ForEach(ZodiacEnum.allCases, id: \.self) { sign in
                VStack {
                    HStack {
                        HStack {
                            Image("\(sign)Small")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            Text(sign.rawValue)
                            .bold()
                        }
                        .frame(width: 150, height: 40)
                        .background(
                            ZStack {
                                Capsule()
                                    .stroke()
                                    .foregroundColor(.blue)
                            }
                        )
                        .padding(5)
                        HStack {
                            Image("\(smallRing[sign]!)Small")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            Text(smallRing[sign]!.rawValue)
                            .bold()
                        }
                        .frame(width: 150, height: 40)
                        .background(
                            ZStack {
                                Capsule()
                                    .stroke()
                                    .foregroundColor(.blue)
                            }
                        )
                        .padding(5)
                    }
                }
            }
        }
    }
    
    var description: some View {
        VStack {
            HStack {
                Button {
                    showDescription = false
                } label: {
                    Label("Назад", systemImage: "chevron.left")
                }
                Spacer()
            }
            .padding()
            ScrollView {
                Text("О малом векторном кольце")
                    .font(.headline)
                    .bold()
                    .padding(.bottom)
                Text(smallRingText)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
    }
}
