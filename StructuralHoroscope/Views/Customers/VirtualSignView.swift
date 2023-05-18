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
    @State private var showFullDescription = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                infoSection
                ForEach(virtualSign.blocks.sorted(by: <), id: \.key) { key, value in
                    VStack(alignment: .leading) {
                        Text(key)
                            .font(.headline)
                        Text(value)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding(18)
        }
        .navigationTitle(virtualSign.virtualSign.rawValue)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                
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

extension VirtualSignView {
    var infoSection: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Что такое виртуальный знак?")
                .bold()
            Text("Зодиакальный и восточный знаки остаются в человеке сами по себе, но рядом с ними появляется еще и третий знак, рожденный от их взаимодействия.\n\nЗодиакальный гороскоп - это здоровье, жизненные планы, амбиции, намерения, а также все характеристики человека в детстве (до 12 лет).\n\nВосточный (годовой) гороскоп - это типы мышления, типы творческой ориентации. Все что связано с поведением человека после 12 лет, в особенности же поведение в любви и браке. Ну и, конечно же, реализация тех самых планов и амбиций, что заложил в человеке зодиакальный знак.\n\nТретий гороскоп, рожденный в борьбе планов и реализации, показывает тип гармонии человека. Соответствие планов и реализации рождает высокую гармоничность, но делает человека менее активным. Слабое соответствие уменьшает гармонию, но увеличивает энергию. Так рождается образ человека, оптимальный имидж. Поскольку речь идет не о реальной сути человека, а только о его образе, создаваемой им картинки, то гороскоп получил название - Виртуальный гороскоп.\n\nЗнаков в новом Виртуальном гороскопе не 12 и не 144, а семь (Король, Вектор, Шут, Рыцарь, Аристократ, Профессор, Вождь). Все названия знаков, также как и описания определены экспериментально, в результате долгих исследований людей сумевших найти выгодный имидж и сделавший на этом карьеру, а также наиболее знаменитых кинообразов отечественного и мирового кино.")
                .foregroundColor(.secondary)
                .lineLimit(showFullDescription ? nil : 2)
            Button {
                showFullDescription.toggle()
            } label: {
                Text(showFullDescription ? "Свернуть" : "Развернуть...")
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(.vertical, 0.001)
            }
            .accentColor(.blue)
        }
        .padding(.bottom, 40)
    }
}
