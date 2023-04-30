//
//  PsychologicalStructView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 30.04.2023.
//

import SwiftUI

struct PsychologicalStructView: View {
    
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

struct PsychologicalStructView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PsychologicalStructView()
        }
        .environmentObject(ViewModel())
    }
}

extension PsychologicalStructView {
    var infoSection: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Что такое психологическая структура?")
                .bold()
            Text("Означенная структура дает ответы на два главных вопроса: как вести себя на бытовом уровне, то есть проявить себя в самых простых и естественных для человека условиях? Таким образом, в плане психологии человек не так уж далеко уходит от статуса животного. Второй вопрос и второй ответ: каковы физиологические особенности человека, что скрывает человек за внешней маской? Ибо все дело в том, что данная структура описывает именно те качества человека, которые тот хотел бы скрыть. Эдакие интимные подробности психологии.\n\nМожет именно из-за интимности психологических качеств, так называемая классическая наука аналогов данных качеств не обнаружила.\n\nПсихология в создании полного портрета человека имеет самый маленький удельный вес. Достаточно большое количество людей вообще не активизируют свою психологию, предпочитая выпячивать и развивать в себе совершенно иные качества. Иногда психологические качества человека уходят на уровень чистой физиологии, не затрагивая его умственную деятельность. Но даже если психология проявляется достаточно сильно, она, как правило, маскируется, причем маскируется по принципу дополнительности. То есть мужественные знаки стараются выглядеть нежно и демонстративно проявляют сентиментальность. Нежные знаки стараются выглядеть достаточно сурово и мужественно. Мечтатели хотят казаться деятельными и мастеровитыми, в свою очередь деятельный человек мечтает показаться человеком отвлеченным и не от мира сего. Так что, даже разгадав психологию человека, стоит считать ее делом интимным и тщательно скрываемым. Может именно из-за интимности психологических качеств, так называемая классическая наука аналогов данных качеств не обнаружила.")
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
            ForEach(PsychologicalEnum.allCases, id: \.rawValue) { item in
                HStack(alignment: .top, spacing: 10) {
                    NavigationLink {
                        PsychologicalView(psychologicalStruct: psychologicalStructs[item]!)
                    } label: {
                        Text(item.rawValue)
                            .frame(width: 145, alignment: .leading)
                    }
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(vm.psychologicalSigns(psychologicalEnum: item)) { sign in
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
