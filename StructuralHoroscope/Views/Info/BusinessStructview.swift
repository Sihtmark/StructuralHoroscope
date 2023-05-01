//
//  BusinessStructview.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 01.05.2023.
//

import SwiftUI

struct BusinessStructview: View {
    
    @EnvironmentObject private var vm: ViewModel
    @State private var showFullDescription1 = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 40) {
                Text("Служебный гороскоп")
                    .font(.title)
                    .bold()
                businessInfo
                signsSection
            }
        }
        .padding(.horizontal)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct BusinessStructview_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            BusinessStructview()
        }
        .environmentObject(ViewModel())
    }
}

extension BusinessStructview {
    var businessInfo: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Что такое служебный гороскоп")
                .font(.headline)
            Text("Актуальность точного формирования коллектива необычайно выросла. Цена ошибки - слабая администрация, провалы в бизнесе. А потому так важно ознакомиться с принципами формирования коллектива.\n\nОбыкновенно работоспособный коллектив создается методом проб и ошибок. Однако такой метод слишком долог и не дает никаких гарантий от случайных и роковых ошибок. А все потому, что жизнь без теории - это гуляние по лесу в полной тьме, дойти-то дойдешь, но шишек много набьешь... Если же к напряженной интуиции добавить хорошую, работающую теорию, то все будет и проще, и надежнее.\n\nТеория проста. Пирамида коллектива выстраивается на одного человека. Он начальник, он глава, все энергетические потоки, все координаты коллектива во времени выстраиваются на него одного. Далее выделяются пять позиций: Вектор, Клон, Соратник, Подчиненный, Советник.")
                .foregroundColor(.secondary)
                .lineLimit(showFullDescription1 ? nil : 2)
            Button {
                withAnimation(.easeInOut) {
                    showFullDescription1.toggle()
                }
            } label: {
                Text(showFullDescription1 ? "Свернуть" : "Развернуть...")
                    .font(.caption)
                    .fontWeight(.bold)
            }
            .accentColor(.blue)
        }
    }
    var signsSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            ForEach(BusinessEnum.allCases, id: \.self) { item in
                NavigationLink {
                    BusinessView(business: businessSigns[item]!, sign: nil)
                } label: {
                    Text(businessSigns[item]!.type.rawValue)
                        .font(.title3)
                }
            }
        }
    }
}
