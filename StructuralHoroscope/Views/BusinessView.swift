//
//  BusinessView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 19.04.2023.
//

import SwiftUI

struct BusinessView: View {
    
    @EnvironmentObject private var VM: ViewModel
    @State private var showFullDescription1 = false
    @State private var showFullDescription2 = false
    let business: BusinessStruct
    let sign: AnnualEnum?
    
    var body: some View {
        ScrollView {
            businessInfo
            businessTypeInfo
            if let sign = sign {
                VStack(alignment: .leading) {
                    Text("Ваши \(business.type.rawValue):")
                        .font(.headline)
                    ForEach(business.signs[sign]!) { sign in
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
        .padding()
        .navigationTitle(business.type.rawValue)
    }
}

struct BusinessView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            BusinessView(business: businessSigns[.adviser]!, sign: sampleClient.sign.annualSign)
        }
        .environmentObject(ViewModel())
    }
}

extension BusinessView {
    var businessInfo: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Служебный гороскоп")
                    .font(.headline)
                Spacer()
                Button {
                    withAnimation {
                        showFullDescription1.toggle()
                    }
                } label: {
                    withAnimation {
                        Image(systemName: showFullDescription1 ? "chevron.up" : "chevron.down")
                    }
                }
            }
            .padding(.bottom, 5)
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
                    .padding(.vertical, 4)
            }
            .accentColor(.blue)
        }
        .padding(.bottom, 40)
    }
    
    var businessTypeInfo: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(business.type.rawValue)
                    .font(.headline)
                Spacer()
                Button {
                    withAnimation {
                        showFullDescription2.toggle()
                    }
                } label: {
                    withAnimation {
                        Image(systemName: showFullDescription2 ? "chevron.up" : "chevron.down")
                    }
                }
            }
            .padding(.bottom, 5)
            Text(business.value)
                .padding(.bottom, 5)
                .foregroundColor(.secondary)
            Text(business.text)
                .foregroundColor(.secondary)
                .lineLimit(showFullDescription2 ? nil : 2)
            Button {
                withAnimation(.easeInOut) {
                    showFullDescription2.toggle()
                }
            } label: {
                Text(showFullDescription2 ? "Свернуть" : "Развернуть...")
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(.vertical, 4)
            }
            .accentColor(.blue)
        }
        .padding(.bottom, 40)
    }
}
