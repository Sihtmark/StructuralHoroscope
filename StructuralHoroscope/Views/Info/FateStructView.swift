//
//  FateStructView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 30.04.2023.
//

import SwiftUI

struct FateStructView: View {
    
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

struct FateStructView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            FateStructView()
        }
        .environmentObject(ViewModel())
    }
}

extension FateStructView {
    
    var signsSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            ForEach(FateEnum.allCases, id: \.rawValue) { item in
                HStack(alignment: .top, spacing: 10) {
                    NavigationLink {
                        FateView(fate: fateStructs[item]!)
                    } label: {
                        Text(item.rawValue)
                            .frame(width: 190, alignment: .leading)
                            .multilineTextAlignment(.leading)
                    }
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(vm.fateSigns(fate: item)) { sign in
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
