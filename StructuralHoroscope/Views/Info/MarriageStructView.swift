//
//  MarriageStructView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 01.05.2023.
//

import SwiftUI

struct MarriageStructView: View {
    
    @EnvironmentObject private var vm: ViewModel
    @State private var shownSign: AnnualEnum = .rat
    @State private var shownStruct: MarriageStruct = vectorMarriage
    
    var body: some View {
        ScrollView {
            signPicker
            mainSignSection
            structPicker
            signSection
            textSection
        }
        .padding(.horizontal)
        .navigationTitle("Построение брака")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MarriageStructView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MarriageStructView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(ViewModel())
        NavigationStack {
            MarriageStructView()
                .preferredColorScheme(.light)
        }
        .environmentObject(ViewModel())
    }
}

extension MarriageStructView {
    var annualSignsSection: some View {
        LazyVStack {
            ScrollView(.horizontal, showsIndicators: true) {
                LazyHStack {
                    ForEach(annualSignArray) { sign in
                        Button {
                            shownSign = sign.annualSign
                        } label: {
                            VStack {
                                Image("\(sign.annualSign)Circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .shadow(radius: 5)
                                Text(sign.annualSign.rawValue)
                                    .font(.caption)
                            }
                            .padding(10)
                        }
                    }
                }
            }
        }
    }
    
    var mainSignSection: some View {
        NavigationLink {
            AnnualSignView(sign: annualSigns[shownSign]!)
        } label: {
            Image("\(shownSign)Circle")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .shadow(radius: 5)
        }
    }
    
    var signPicker: some View {
        Picker("asdf", selection: $shownSign) {
            ForEach(AnnualEnum.allCases, id: \.self) { item in
                Text(item.rawValue).tag(item)
            }
        }
    }
    
    var structPicker: some View {
        Picker("asdf", selection: $shownStruct) {
            ForEach(marriages) { item in
                Text(item.type.rawValue).tag(item)
            }
        }
    }
    
    var signSection: some View {
        HStack {
            ForEach(shownStruct.signs[shownSign]!, id: \.self) { item in
                NavigationLink {
                    AnnualSignView(sign: item)
                } label: {
                    VStack {
                        Image("\(item.annualSign)Circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .shadow(radius: 5)
                        Text(item.annualSign.rawValue)
                            .font(.caption)
                    }
                    .padding(10)
                }
            }
        }
    }
    
    var textSection: some View {
        VStack {
            Text(shownStruct.title)
                .font(.headline)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.bottom)
            Text(shownStruct.text)
                .foregroundColor(.theme.secondaryText)
        }
    }
}
