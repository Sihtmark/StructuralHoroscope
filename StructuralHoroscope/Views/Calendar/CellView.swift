//
//  CellView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 06.05.2023.
//

import SwiftUI

struct CellView: View {
    
    let dateInfo: DayStruct
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            ForEach(AnnualEnum.allCases, id: \.self) { item in
                HStack {
                    NavigationLink {
                        AnnualSignView(sign: annualSigns[item]!)
                    } label: {
                        Text(item.rawValue)
                            .frame(width: 100, alignment: .leading)
                    }
                    Text(dateInfo.signs[item]!.rawValue)
                }
            }
        }
    }
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CellView(dateInfo: firstDay)
        }.environmentObject(ViewModel())
    }
}
