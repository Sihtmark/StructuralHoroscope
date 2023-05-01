//
//  MarriageStructView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 01.05.2023.
//

import SwiftUI

struct MarriageStructView: View {
    
    @EnvironmentObject private var vm: ViewModel
    @State private var showFullDescription1 = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 40) {
                Text("Типы браков")
                    .font(.title)
                    .bold()
                signsSection
            }
        }
        .padding(.horizontal)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MarriageStructView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MarriageStructView()
        }
        .environmentObject(ViewModel())
    }
}

extension MarriageStructView {
    var signsSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            ForEach(marriages) { marriage in
                NavigationLink {
                    MarriageView(marriage: marriage, sign: nil)
                } label: {
                    Text(marriage.type.rawValue)
                        .font(.title3)
                }
            }
        }
    }
}
