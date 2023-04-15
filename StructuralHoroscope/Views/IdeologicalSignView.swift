//
//  IdeologicalSignView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 15.04.2023.
//

import SwiftUI

struct IdeologicalSignView: View {
    
    @EnvironmentObject private var VM: ViewModel
    @State private var showFullDescription1 = false
    @State private var showFullDescription2 = false
    let ideologicalStruct: IdeologicalStruct
    
    var body: some View {
        ScrollView {
            maleSection
            femaleSection
        }
        .padding(.horizontal)
        .navigationTitle(ideologicalStruct.ideologicalType.rawValue)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    
                } label: {
                    Image(systemName: "info.circle")
                }
            }
        }
    }
}

struct IdeologicalSignView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            IdeologicalSignView(ideologicalStruct: mysticIdeologicalStruct)
        }
        .environmentObject(ViewModel())
    }
}

extension IdeologicalSignView {
    var maleSection: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(ideologicalStruct.blocks[Sex.male]!.0)
                    .font(.headline)
                Spacer()
                Button {
                    showFullDescription1.toggle()
                } label: {
                    withAnimation {
                        Image(systemName: showFullDescription1 ? "chevron.up" : "chevron.down")
                    }
                }
            }
            .padding(.bottom, 5)
            .padding(.top, 30)
            Text(ideologicalStruct.blocks[Sex.male]!.1)
                .foregroundColor(.secondary)
                .lineLimit(showFullDescription1 ? nil : 2)
            Button {
                withAnimation(.easeInOut) {
                    showFullDescription1.toggle()
                }
            } label: {
                Text(showFullDescription1 ? "Less" : "Read more...")
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(.vertical, 4)
            }
            .accentColor(.blue)
        }
    }
    
    var femaleSection: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(ideologicalStruct.blocks[Sex.female]!.0)
                    .font(.headline)
                Spacer()
                Button {
                    showFullDescription2.toggle()
                } label: {
                    withAnimation {
                        Image(systemName: showFullDescription2 ? "chevron.up" : "chevron.down")
                    }
                }
            }
            .padding(.bottom, 5)
            .padding(.top, 30)
            Text(ideologicalStruct.blocks[Sex.female]!.1)
                .foregroundColor(.secondary)
                .lineLimit(showFullDescription2 ? nil : 2)
            Button {
                withAnimation(.easeInOut) {
                    showFullDescription2.toggle()
                }
            } label: {
                Text(showFullDescription2 ? "Less" : "Read more...")
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(.vertical, 4)
            }
            .accentColor(.blue)
        }
    }
}
