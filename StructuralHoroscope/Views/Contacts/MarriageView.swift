//
//  SectionView.swift
//  StructuralHoroscope
//
//  Created by sihtmark on 01.08.2023.
//

import SwiftUI

struct MarriageView: View {
    
    let marriageStruct: MarriageStruct
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            HStack {
                Spacer()
                Text(marriageStruct.title)
                    .foregroundColor(.theme.standard)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            Text(marriageStruct.text)
                .foregroundColor(.theme.secondaryText)
                .padding(.bottom)
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct ContactMarriageView_Previews: PreviewProvider {
    static var previews: some View {
        MarriageView(marriageStruct: spiritualMarriage)
    }
}
