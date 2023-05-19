//
//  BusinessStructview.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 01.05.2023.
//

import SwiftUI

struct BusinessStructview: View {
    
    @EnvironmentObject private var vm: ViewModel
    @State private var shownSign: AnnualEnum = .rat
    @State private var shownStruct: BusinessStruct = clone
    @State private var showDescription = false
    
    var body: some View {
        ScrollView {
            HStack(spacing: -5) {
                Text("Начальник:")
                signPicker
            }
            structPicker
            signSection
            textSection
        }
        .padding(.horizontal)
        .navigationTitle("Построение коллектива")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showDescription = true
                } label: {
                    Image(systemName: "info.circle")
                }
            }
        }
        .sheet(isPresented: $showDescription) {
            description
        }
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
    var annualSignsSection: some View {
        LazyVStack {
            ScrollView(.horizontal, showsIndicators: true) {
                LazyHStack {
                    ForEach(annualSignArray) { sign in
                        Button {
                            shownSign = sign.annualSign
                        } label: {
                            VStack {
                                Image("\(sign.annualSign)Circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .shadow(radius: 5)
                                Text(sign.annualSign.rawValue)
                                    .font(.caption)
                            }
                            .padding(10)
                        }
                    }
                }
            }
        }
    }
    
    var signPicker: some View {
        Picker("asdf", selection: $shownSign) {
            ForEach(AnnualEnum.allCases, id: \.self) { item in
                Text(item.rawValue).tag(item)
            }
        }
    }
    
    var structPicker: some View {
        Picker("asdf", selection: $shownStruct) {
            ForEach(businessArray) { item in
                Text(item.type.rawValue).tag(item)
            }
        }
    }
    
    var signSection: some View {
        HStack {
            ForEach(shownStruct.signs[shownSign]!, id: \.self) { item in
                NavigationLink {
                    AnnualSignView(sign: item)
                } label: {
                    VStack {
                        Image("\(item.annualSign)Circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .shadow(radius: 5)
                        Text(item.annualSign.rawValue)
                            .font(.caption)
                    }
                    .padding(10)
                }
            }
        }
    }
    
    var textSection: some View {
        VStack {
            Text(shownStruct.value)
                .font(.headline)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.bottom)
            Text(shownStruct.text)
                .foregroundColor(.secondary)
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
    
    var description: some View {
        VStack {
            HStack {
                Button {
                    showDescription = false
                } label: {
                    Label("Назад", systemImage: "chevron.left")
                }
                Spacer()
            }
            .padding()
            VStack {
                Text("Что такое построение коллектива")
                    .font(.headline)
                    .bold()
                    .padding(.bottom)
                Text("Актуальность точного формирования коллектива необычайно выросла. Цена ошибки - слабая администрация, провалы в бизнесе. А потому так важно ознакомиться с принципами формирования коллектива.\n\nОбыкновенно работоспособный коллектив создается методом проб и ошибок. Однако такой метод слишком долог и не дает никаких гарантий от случайных и роковых ошибок. А все потому, что жизнь без теории - это гуляние по лесу в полной тьме, дойти-то дойдешь, но шишек много набьешь... Если же к напряженной интуиции добавить хорошую, работающую теорию, то все будет и проще, и надежнее.\n\nТеория проста. Пирамида коллектива выстраивается на одного человека. Он начальник, он глава, все энергетические потоки, все координаты коллектива во времени выстраиваются на него одного. Далее выделяются пять позиций: Вектор, Клон, Соратник, Подчиненный, Советник.")
                    .foregroundColor(.secondary)
                Spacer()
            }
        }
        .padding()
    }
}
