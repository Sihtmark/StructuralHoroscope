//
//  ElementStructView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 30.04.2023.
//

import SwiftUI

struct ElementStructView: View {
    
    @EnvironmentObject private var vm: ViewModel
    @State private var showFullDescription = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 40) {
                HStack {
                    Text("Структура стихий")
                        .font(.title)
                        .bold()
                    Spacer()
                }
                infoSection
                signsSection
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .padding()
    }
}

struct ElementStructView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ElementStructView()
        }
        .environmentObject(ViewModel())
    }
}

extension ElementStructView {
    var infoSection: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Что такое Структура стихий?")
                .bold()
            Text("Чувственная структура зодиакальных знаков: тренеры-садисты (Водолей, Овен, Близнецы), спортсмены-мазохисты (Скорпион, Козерог, Рыбы), повара (Лев, Весы, Стрелец) и гурманы (Телец, Рак, Дева)… Из той самой чувственной структуры, в частности, следовало, что главными делателями, людьми, рассчитывающими свои дела на долгий срок, являются так называемые четные знаки: Водолей, Овен, Близнецы, Лев, Весы, Стрелец. Они по праву должны поделить между собой медленные, стабильные стихии: Землю и Воздух, оставив экстренные стихии (Огонь и Воду) нечетным знакам-торопыгам.")
                .foregroundColor(.secondary)
                .lineLimit(showFullDescription ? nil : 2)
            Button {
                withAnimation(.easeInOut) {
                    showFullDescription.toggle()
                }
            } label: {
                Text(showFullDescription ? "Свернуть" : "Развернуть...")
                    .font(.caption)
                    .fontWeight(.bold)
            }
            .accentColor(.blue)
        }
    }
    var signsSection: some View {
        VStack(alignment: .leading, spacing: 30) {
            ForEach(elements) { element in
                VStack(alignment: .leading, spacing: 10) {
                    Text(element.element.rawValue)
                        .font(.title3)
                        .bold()
                    HStack(spacing: 30) {
                        ForEach(element.zodiacs, id: \.self) { zodiac in
                            Text(zodiac.rawValue)
                        }
                    }
                    Text(element.text)
                        .foregroundColor(.secondary)
                        .lineLimit(showFullDescription ? nil : 2)
                    Button {
                        withAnimation(.easeInOut) {
                            showFullDescription.toggle()
                        }
                    } label: {
                        Text(showFullDescription ? "Свернуть" : "Развернуть...")
                            .font(.caption)
                            .fontWeight(.bold)
                    }
                    .accentColor(.blue)
                }
            }
        }
    }
}

