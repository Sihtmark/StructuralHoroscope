//
//  SensualityStructView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 30.04.2023.
//

import SwiftUI

struct SensualityStructView: View {
    
    @EnvironmentObject private var vm: ViewModel
    @State private var shownStruct: SensualityStruct = coach
    
    var body: some View {
        ScrollView {
            picker
            infoSection
        }
        .navigationTitle("Структура чувственности")
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal)
    }
}

struct SensualityStructView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SensualityStructView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(ViewModel())
        NavigationStack {
            SensualityStructView()
                .preferredColorScheme(.light)
        }
        .environmentObject(ViewModel())
    }
}

extension SensualityStructView {
    var picker: some View {
        Picker("asdf", selection: $shownStruct) {
            ForEach(sensualityArray) { item in
                Text(item.department.rawValue).tag(item)
            }
        }
    }
    
    var infoSection: some View {
        VStack {
            HStack {
                ForEach(shownStruct.zodiacs, id: \.self) { item in
                    VStack {
                        Image("\(item)Circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .shadow(radius: 5)
                        Text(item.rawValue)
                            .font(.caption)
                            .foregroundColor(.theme.accent)
                    }
                    .padding(10)
                }
            }
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
