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
                .preferredColorScheme(.dark)
        }
        .environmentObject(ViewModel())
        NavigationStack {
            SmallVectorRingView()
                .preferredColorScheme(.light)
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
                        ZStack {
                            Capsule()
                                .stroke(lineWidth: 0.4)
                                .foregroundColor(.theme.red)
                                .frame(width: 150, height: 40)
                            HStack {
                                Image("\(sign)Small")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                Text(sign.rawValue)
                                    .foregroundColor(.theme.red)
                                .bold()
                            }
                        .padding(5)
                        }
                        .padding(.trailing, 10)
                        ZStack {
                            Capsule()
                                .stroke(lineWidth: 0.4)
                                .foregroundColor(.theme.blue)
                                .frame(width: 150, height: 40)
                            HStack {
                                Image("\(smallRing[sign]!)Small")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                Text(smallRing[sign]!.rawValue)
                                    .foregroundColor(.theme.blue)
                                .bold()
                            }
                        .padding(5)
                        }
                    }
                    .padding(.bottom, 10)
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
                    .foregroundColor(.theme.secondaryText)
            }
        }
        .padding()
    }
}
