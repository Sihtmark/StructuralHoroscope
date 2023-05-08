//
//  PsychologicalView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 19.04.2023.
//

import SwiftUI

struct PsychologicalView: View {
    
    let psychologicalStruct: PsychologicalStruct
    @EnvironmentObject private var VM: ViewModel
    @State private var showFullDescription1 = false
    @State private var showFullDescription2 = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Text("Психологическая структура")
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
                Text("Означенная структура дает ответы на два главных вопроса: как вести себя на бытовом уровне, то есть проявить себя в самых простых и естественных для человека условиях? Таким образом, в плане психологии человек не так уж далеко уходит от статуса животного. Второй вопрос и второй ответ: каковы физиологические особенности человека, что скрывает человек за внешней маской? Ибо все дело в том, что данная структура описывает именно те качества человека, которые тот хотел бы скрыть. Эдакие интимные подробности психологии.\n\nМожет именно из-за интимности психологических качеств, так называемая классическая наука аналогов данных качеств не обнаружила.\n\nПсихология в создании полного портрета человека имеет самый маленький удельный вес. Достаточно большое количество людей вообще не активизируют свою психологию, предпочитая выпячивать и развивать в себе совершенно иные качества. Иногда психологические качества человека уходят на уровень чистой физиологии, не затрагивая его умственную деятельность. Но даже если психология проявляется достаточно сильно, она, как правило, маскируется, причем маскируется по принципу дополнительности. То есть мужественные знаки стараются выглядеть нежно и демонстративно проявляют сентиментальность. Нежные знаки стараются выглядеть достаточно сурово и мужественно. Мечтатели хотят казаться деятельными и мастеровитыми, в свою очередь деятельный человек мечтает показаться человеком отвлеченным и не от мира сего. Так что, даже разгадав психологию человека, стоит считать ее делом интимным и тщательно скрываемым. Может именно из-за интимности психологических качеств, так называемая классическая наука аналогов данных качеств не обнаружила.")
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
                    Text(psychologicalStruct.title)
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
                Text(psychologicalStruct.text)
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
                
                ForEach(VM.psychologicalSigns(psychologicalEnum: psychologicalStruct.psychologicalType)) { sign in
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
        .navigationTitle(psychologicalStruct.psychologicalType.rawValue)
    }
}

struct Psychological_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PsychologicalView(psychologicalStruct: sampleClient.annualSignStruct.psychologicalType)
        }
        .environmentObject(ViewModel())
    }
}
