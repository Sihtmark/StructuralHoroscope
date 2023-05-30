//
//  ElementStructView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 30.04.2023.
//

import SwiftUI

struct ElementStructView: View {
    
    @EnvironmentObject private var vm: ViewModel
    @State private var shownStruct: ElementStruct = earthElement
    @State private var showDescription = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            picker
            infoSection
        }
        .frame(maxWidth: 900)
        .padding(.horizontal)
        .navigationTitle("Социальная структура")
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

struct ElementStructView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ElementStructView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(ViewModel())
        NavigationStack {
            ElementStructView()
                .preferredColorScheme(.light)
        }
        .environmentObject(ViewModel())
    }
}

extension ElementStructView {
    var picker: some View {
        Picker("asdf", selection: $shownStruct) {
            ForEach(elements) { item in
                Text(item.element.rawValue).tag(item)
            }
        }
    }
    
    var infoSection: some View {
        VStack {
            HStack {
                ForEach(shownStruct.zodiacs, id: \.self) { item in
                    VStack {
                        Image("\(item)Circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .shadow(radius: 5)
                        Text(item.rawValue)
                            .font(.caption)
                            .foregroundColor(.theme.accent)
                    }
                    .padding(10)
                }
            }
            Text(shownStruct.text)
                .foregroundColor(.theme.secondaryText)
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
                Text("Что такое Структура стихий?")
                    .foregroundColor(.theme.standard)
                    .font(.headline)
                    .bold()
                    .padding(.bottom)
                Text("Чувственная структура зодиакальных знаков: тренеры-садисты (Водолей, Овен, Близнецы), спортсмены-мазохисты (Скорпион, Козерог, Рыбы), повара (Лев, Весы, Стрелец) и гурманы (Телец, Рак, Дева)… Из той самой чувственной структуры, в частности, следовало, что главными делателями, людьми, рассчитывающими свои дела на долгий срок, являются так называемые четные знаки: Водолей, Овен, Близнецы, Лев, Весы, Стрелец. Они по праву должны поделить между собой медленные, стабильные стихии: Землю и Воздух, оставив экстренные стихии (Огонь и Воду) нечетным знакам-торопыгам.")
                    .foregroundColor(.theme.secondaryText)
                Spacer()
            }
        }
        .padding()
    }
}
