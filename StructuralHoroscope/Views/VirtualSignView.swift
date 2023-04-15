//
//  VirtualSignView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 13.04.2023.
//

import SwiftUI

struct VirtualSignView: View {
    
    @EnvironmentObject private var VM: ViewModel
    let virtualSign: VirtualSignStruct
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(virtualSign.blocks.sorted(by: <), id: \.key) { key, value in
                    VStack(alignment: .leading) {
                        Text(key)
                            .font(.headline)
                        Text(value)
                            .foregroundColor(.secondary)
                    }
                }
                Link("Read more on site", destination: URL(string: virtualSign.site)!)
            }
            .padding(18)
        }
        .navigationTitle("Аристократ")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Link(destination: URL(string: virtualSign.site)!) {
                    Image(systemName: "globe")
                }
            }
        }
    }
}

struct VirtualSignView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            VirtualSignView(virtualSign: virtualSigns[1])
        }
        .environmentObject(ViewModel())
    }
}
