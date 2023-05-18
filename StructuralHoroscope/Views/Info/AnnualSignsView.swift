//
//  AnnualSignsView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 29.04.2023.
//

import SwiftUI

struct AnnualSignsView: View {
    
    @EnvironmentObject private var VM: ViewModel
    @State private var showFullDescription = false
    @State private var shownAnnualSign: SignStruct = ratSign
    let rows: [GridItem] = [
        GridItem(.fixed(50), spacing: 15, alignment: .center),
        GridItem(.fixed(50), spacing: 15, alignment: .center)
    ]
    
    var body: some View {
        VStack {
            LazyHGrid(rows: rows, alignment: .top, spacing: 10) {
                ForEach(annualSignArray) { sign in
                    Button {
                        shownAnnualSign = sign
                    } label: {
                        Image("\(sign.annualSign)Circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .shadow(radius: 5)
                    }
                }
            }
            .frame(height: 120)
            .padding(.top, 15)
            AnnualSignView(sign: shownAnnualSign)
        }
        .navigationTitle("Годовые знаки")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AnnualSignsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AnnualSignsView()
        }
        .environmentObject(ViewModel())
    }
}
