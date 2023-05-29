//
//  FateStructView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 30.04.2023.
//

import SwiftUI

struct FateStructView: View {
    
    @EnvironmentObject private var vm: ViewModel
    @State private var shownStruct: EnergyStruct = dramaticEnergeticStruct
    
    var body: some View {
        VStack {
            picker
            infoSection
            Spacer()
        }
        .navigationTitle("Энергетическая структура")
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal)
    }
}

struct FateStructView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            FateStructView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(ViewModel())
        NavigationStack {
            FateStructView()
                .preferredColorScheme(.light)
        }
        .environmentObject(ViewModel())
    }
}

extension FateStructView {
    var picker: some View {
        Picker("asdf", selection: $shownStruct) {
            ForEach(energyArray) { item in
                Text(item.energyType.rawValue).tag(item)
            }
        }
    }
    
    var infoSection: some View {
        VStack {
            HStack {
                ForEach(shownStruct.signs, id: \.self) { item in
                    NavigationLink {
                        AnnualSignView(sign: annualSigns[item]!)
                    } label: {
                        VStack {
                            Image("\(annualSigns[item]!.annualSign)Circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .shadow(radius: 5)
                        }
                        .padding(10)
                    }
                }
            }
            Text(shownStruct.title)
                .foregroundColor(.theme.standard)
                .font(.headline)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.bottom)
            Text(shownStruct.text)
                .foregroundColor(.theme.secondaryText)
        }
    }
}
