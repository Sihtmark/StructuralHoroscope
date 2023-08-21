//
//  BusinessView.swift
//  StructuralHoroscope
//
//  Created by sihtmark on 01.08.2023.
//

import SwiftUI

struct BusinessView: View {
    let business: BusinessStruct

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Text(business.type.rawValue)
                    .foregroundColor(.theme.standard)
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 15)
            HStack {
                Text(business.value)
                    .foregroundColor(.theme.secondaryText)
                    .padding(.bottom, 15)
                Spacer()
            }
            Text(business.text)
                .foregroundColor(.theme.secondaryText)
                .padding(.bottom)
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct BusinessView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessView(business: adviser)
    }
}
