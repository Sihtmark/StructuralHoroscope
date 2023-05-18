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
    
    var body: some View {
        VStack {
            annualSigns
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

extension AnnualSignsView {
    var annualSigns: some View {
        LazyVStack {
            ScrollView(.horizontal, showsIndicators: true) {
                LazyHStack {
                    ForEach(annualSignArray) { sign in
                        Button {
                            shownAnnualSign = sign
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
}
