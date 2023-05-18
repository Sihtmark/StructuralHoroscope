//
//  EnergyStructView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 30.04.2023.
//

import SwiftUI

struct EnergyStructView: View {
    
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

struct EnergyStructView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            EnergyStructView()
        }
        .environmentObject(ViewModel())
    }
}

extension EnergyStructView {
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
                            Text(annualSigns[item]!.annualSign.rawValue)
                                .font(.caption)
                                .foregroundColor(.black)
                        }
                        .padding(10)
                    }
                }
            }
            Text(shownStruct.title)
                .font(.headline)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.bottom)
            Text(shownStruct.text)
                .foregroundColor(.secondary)
        }
    }
}
