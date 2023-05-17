//
//  EnergyView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 19.04.2023.
//

import SwiftUI

struct EnergyView: View {
    
    let energy: EnergyStruct
    @EnvironmentObject private var VM: ViewModel
    @State private var showFullDescription = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(energy.title)
                .font(.headline)
                .padding(.vertical)
            Text(energy.text)
                .foregroundColor(.secondary)
            ForEach(VM.energySigns(energy: energy.energyType)) { sign in
                NavigationLink {
                    AnnualSignView(sign: sign)
                } label: {
                    HStack {
                        Text(sign.annualSign.rawValue)
                            .font(.title3)
                            .padding(.top)
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                }
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Темперамент")
    }
}


struct Energy_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            EnergyView(energy: sampleClient.annualSignStruct.temperament)
        }
        .environmentObject(ViewModel())
    }
}
