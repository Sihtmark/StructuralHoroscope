//
//  MerrigeView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 19.04.2023.
//

import SwiftUI

struct MarriageView: View {
    
    @EnvironmentObject private var VM: ViewModel
    @State private var showFullDescription = false
    let marriage: MarriageStruct
    let sign: AnnualEnum?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                marriageInfoSection
                if let sign = sign {
                    signsSection
                }
            }
        }
        .padding()
    }
}

struct MarriageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MarriageView(marriage: romanticMarriage, sign: .tiger)
        }
        .environmentObject(ViewModel())
    }
}

extension MarriageView {
    var marriageInfoSection: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(marriage.title)
                    .font(.headline)
                Spacer()
                Button {
                    withAnimation {
                        showFullDescription.toggle()
                    }
                } label: {
                    withAnimation {
                        Image(systemName: showFullDescription ? "chevron.up" : "chevron.down")
                    }
                }
            }
            .padding(.bottom, 5)
            Text(marriage.text)
                .foregroundColor(.secondary)
                .lineLimit(showFullDescription ? nil : 2)
            Button {
                withAnimation(.easeInOut) {
                    showFullDescription.toggle()
                }
            } label: {
                Text(showFullDescription ? "Свернуть" : "Развернуть...")
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(.vertical, 4)
            }
            .accentColor(.blue)
        }
        .padding(.bottom, 40)
    }
    var signsSection: some View {
        VStack(alignment: .leading) {
            Text("Знаки:")
                .font(.headline)
            ForEach(marriage.signs[sign!]!) { sign in
                NavigationLink {
                    AnnualSignView(sign: sign)
                } label: {
                    HStack {
                        Text(sign.annualSign.rawValue)
                        Spacer()
                    }
                    .padding(.top, -5)
                }
            }
        }
    }
}
