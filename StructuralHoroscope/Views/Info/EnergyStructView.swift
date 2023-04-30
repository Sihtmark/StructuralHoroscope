//
//  EnergyStructView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 30.04.2023.
//

import SwiftUI

struct EnergyStructView: View {
    
    @EnvironmentObject private var vm: ViewModel
    @State private var showFullDescription = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 40) {
                HStack {
                    Text("Энергетическая структура")
                        .font(.title)
                        .bold()
                    Spacer()
                }
                signsSection
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .padding()
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
    
    var signsSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            ForEach(EnergyEnum.allCases, id: \.rawValue) { item in
                HStack(alignment: .top, spacing: 10) {
                    NavigationLink {
                        EnergyView(energy: energyStructs[item]!)
                    } label: {
                        Text(item.rawValue)
                            .frame(width: 190, alignment: .leading)
                            .multilineTextAlignment(.leading)
                    }
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(vm.energySigns(energy: item)) { sign in
                            NavigationLink {
                                AnnualSignView(sign: sign)
                            } label: {
                                Text(sign.annualSign.rawValue)
                            }
                        }
                    }
                }
            }
        }
    }
}
