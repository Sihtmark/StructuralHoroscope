//
//  VirtualSignsInfo.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 12.04.2023.
//

import SwiftUI

struct VirtualSignsInfo: View {
    
    @EnvironmentObject var VM: ViewModel
    @State private var showFullDescription = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                virtualText
                    .padding(.bottom, 30)
                aristokratLink
                vectorLink
                professorLink
                knightLink
                leaderLink
                jesterLink
                kingLink
            }
        }
        .navigationTitle("Виртуальные знаки")
        .padding()
    }
}

struct VirtualSignsInfo_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            VirtualSignsInfo()
        }
        .environmentObject(ViewModel())
    }
}

extension VirtualSignsInfo {
    var virtualText: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Зодиакальный и восточный знаки остаются в человеке сами по себе, но рядом с ними появляется еще и третий знак, рожденный от их взаимодействия.\n\nЗодиакальный гороскоп" + " - это типы мышления, типы творческой ориентации. Все что связано с поведением человека после 12 лет, в особенности же поведение в любви и браке. Ну и, конечно же, реализация тех самых планов и амбиций, что заложил в человеке зодиакальный знак\n\nТретий гороскоп, рожденный в борьбе планов и реализации, показывает тип гармонии человека. Соответствие планов и реализации рождает высокую гармоничность, но делает человека менее активным. Слабое соответствие уменьшает гармонию, но увеличивает энергию. Так рождается образ человека, оптимальный имидж. Поскольку речь идет не о реальной сути человека, а только о его образе, создаваемой им картинки, то гороскоп получил название - Виртуальный гороскоп.\n\nЗнаков в новом Виртуальном гороскопе не 12 и не 144, а семь (Король, Вектор, Шут, Рыцарь, Аристократ, Профессор, Вождь). Все названия знаков, также как и описания определены экспериментально, в результате долгих исследований людей сумевших найти выгодный имидж и сделавший на этом карьеру, а также наиболее знаменитых кинообразов отечественного и мирового кино.")
                .lineLimit(showFullDescription ? nil : 4)
                .font(.callout)
                .foregroundColor(.secondary)
            HStack {
                Button {
                    withAnimation(.easeInOut) {
                        showFullDescription.toggle()
                    }
                } label: {
                    Text(showFullDescription ? "Less" : "Read more...")
                        .font(.caption)
                        .fontWeight(.bold)
                }
                .accentColor(.blue)
                if showFullDescription {
                    Spacer()
                    Link("Read more on site", destination: URL(string: "https://www.xsp.ru/sh/virt/")!)
                        .font(.caption)
                        .bold()
                }
            }
        }
    }
    var aristokratLink: some View {
        NavigationLink {
            AristocratView()
        } label: {
            Text("Аристократ")
                .font(.title3)
        }
    }
    var vectorLink: some View {
        NavigationLink {
            VectorView()
        } label: {
            Text("Вектор")
                .font(.title3)
        }
    }
    var professorLink: some View {
        NavigationLink {
            ProfessorView()
        } label: {
            Text("Профессор")
                .font(.title3)
        }
    }
    var knightLink: some View {
        NavigationLink {
            KnightView()
        } label: {
            Text("Рыцарь")
                .font(.title3)
        }
    }
    var leaderLink: some View {
        NavigationLink {
            LeaderView()
        } label: {
            Text("Лидер")
                .font(.title3)
        }
    }
    var jesterLink: some View {
        NavigationLink {
            JesterView()
        } label: {
            Text("Шут")
                .font(.title3)
        }
    }
    var kingLink: some View {
        NavigationLink {
            KingView()
        } label: {
            Text("Король")
                .font(.title3)
        }
    }
}
