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
                .frame(maxWidth: 550)
        }
        .navigationTitle("Годовые знаки")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AnnualSignsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AnnualSignsView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(ViewModel())
        NavigationStack {
            AnnualSignsView()
                .preferredColorScheme(.light)
        }
        .environmentObject(ViewModel())
    }
}

extension AnnualSignsView {
    var annualSigns: some View {
        LazyVStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(annualSignArray) { sign in
                        Button {
                            shownAnnualSign = sign
                        } label: {
                            VStack {
                                Image("\(sign.annualSign)Circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 55, height: 55)
                                    .shadow(radius: 5)
                            }
                            .padding(10)
                        }
                    }
                }
            }
        }
    }
}
