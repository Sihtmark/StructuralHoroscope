//
//  FateView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 19.04.2023.
//

import SwiftUI

struct FateView: View {
    
    let fate: FateStruct
    @EnvironmentObject private var VM: ViewModel
    @State private var showFullDescription = false
    
    var body: some View {
        ScrollView {
            Text(fate.title)
                .font(.headline)
                .padding(.vertical)
            Text(fate.text)
                .foregroundColor(.secondary)
            ForEach(VM.fateSigns(fate: fate.fateType)) { sign in
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
        .navigationTitle("Структура судьбы")
    }
}


struct Fate_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            FateView(fate: sampleClient.sign.fateType)
        }
        .environmentObject(ViewModel())
    }
}

