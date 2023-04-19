//
//  SocialView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 18.04.2023.
//

import SwiftUI

struct SocialView: View {
    
    let social: SocialStruct
    @EnvironmentObject private var VM: ViewModel
    @State private var showFullDescription1 = false
    @State private var showFullDescription2 = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Text("Социальная структура")
                        .font(.headline)
                    Spacer()
                    Button {
                        showFullDescription1.toggle()
                    } label: {
                        withAnimation {
                            Image(systemName: showFullDescription1 ? "chevron.up" : "chevron.down")
                        }
                    }
                }
                .padding(.bottom, 5)
                .padding(.top, 30)
                Text("Социальная структура объясняет как взаимодействует человек с пространством (сжимается, растекается или желает сохранить сферу обитания стабильной). И второе: как относиться к обществу, быть выше его, подчиняться его запросам, либо быть с ним заодно.\n\nОбщение человека или говоря по-научному социальная и пространственная ориентация, отсылают нас к то ли к социологии, то ли к юнговской соционической доктрине, которые чрезвычайно переоценивают момент общения. На самом же деле социальная ориентация не имеет слишком ярких внешних проявлений, действует в ограниченном спектре творческих занятий. Кроме того, социальность знаков разная на Востоке, на Западе и в государствах с имперским ритмом. Но при всех этих оговорках общение важнее психологии, что само по себе уже не мало.\n\nКлассические наименования введены Юнгом и хорошо известны: интроверт и экстраверт. Однако Юнг прозевал третий вариант - ортодокс. Интроверты, - закрытые знаки, экстраверты - открытые. Ортодоксы - те, кто охраняют ограниченную территорию, стабильность своего положения.")
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
                HStack {
                    Text(social.title)
                        .font(.headline)
                    Spacer()
                    Button {
                        showFullDescription2.toggle()
                    } label: {
                        withAnimation {
                            Image(systemName: showFullDescription2 ? "chevron.up" : "chevron.down")
                        }
                    }
                }
                .padding(.bottom, 5)
                .padding(.top, 30)
                Text(social.text)
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
                
                ForEach(VM.socialSigns(socialEnum: social.socialType)) { sign in
                    NavigationLink {
                        AnnualSignView(sign: sign)
                    } label: {
                        HStack {
                            Text(sign.annualSign.rawValue)
                                .font(.title3)
                                .padding(.top)
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle(social.socialType.rawValue)
    }
}

struct SocialView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SocialView(social: sampleClient.sign.socialType)
        }
        .environmentObject(ViewModel())
    }
}
