//
//  SocialStructView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 30.04.2023.
//

import SwiftUI

struct SocialStructView: View {
    
    @EnvironmentObject private var vm: ViewModel
    @State private var showFullDescription = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 40) {
                HStack {
                    Text("Социальная структура")
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

struct SocialStructView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SocialStructView()
        }
        .environmentObject(ViewModel())
    }
}

extension SocialStructView {
    var infoSection: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Что такое социальная структура?")
                .bold()
            Text("Социальная структура объясняет как взаимодействует человек с пространством (сжимается, растекается или желает сохранить сферу обитания стабильной). И второе: как относиться к обществу, быть выше его, подчиняться его запросам, либо быть с ним заодно.\n\nОбщение человека или говоря по-научному социальная и пространственная ориентация, отсылают нас к то ли к социологии, то ли к юнговской соционической доктрине, которые чрезвычайно переоценивают момент общения. На самом же деле социальная ориентация не имеет слишком ярких внешних проявлений, действует в ограниченном спектре творческих занятий. Кроме того, социальность знаков разная на Востоке, на Западе и в государствах с имперским ритмом. Но при всех этих оговорках общение важнее психологии, что само по себе уже не мало.\n\nКлассические наименования введены Юнгом и хорошо известны: интроверт и экстраверт. Однако Юнг прозевал третий вариант - ортодокс. Интроверты, - закрытые знаки, экстраверты - открытые. Ортодоксы - те, кто охраняют ограниченную территорию, стабильность своего положения.")
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
        VStack(alignment: .leading, spacing: 15) {
            ForEach(SocialEnum.allCases, id: \.rawValue) { item in
                HStack(alignment: .top, spacing: 10) {
                    NavigationLink {
                        SocialView(social: socialStructs[item]!)
                    } label: {
                        Text(item.rawValue)
                            .frame(width: 100, alignment: .leading)
                    }
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(vm.socialSigns(socialEnum: item)) { sign in
                            NavigationLink {
                                AnnualSignView(sign: sign)
                            } label: {
                                Text(sign.annualSign.rawValue)
                            }
                        }
                    }
                }
            }
        }
    }
}
