//
//  PsychologicalStructView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 30.04.2023.
//

import SwiftUI

struct PsychologicalStructView: View {
    
    @EnvironmentObject private var vm: ViewModel
    @State private var shownPsychologicalStruct: PsychologicalStruct = maturityPsychologicalStruct
    @State private var showDescription = false
    
    var body: some View {
        ScrollView {
            picker
            infoSection
        }
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

struct PsychologicalStructView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PsychologicalStructView()
        }
        .environmentObject(ViewModel())
    }
}

extension PsychologicalStructView {
    var picker: some View {
        Picker("asdf", selection: $shownPsychologicalStruct) {
            ForEach(psychologicalArray) { item in
                Text(item.psychologicalType.rawValue).tag(item)
            }
        }
    }
    
    var infoSection: some View {
        VStack {
            HStack {
                ForEach(shownPsychologicalStruct.signs, id: \.self) { item in
                    NavigationLink {
                        AnnualSignView(sign: annualSigns[item]!)
                    } label: {
                        VStack {
                            Image("\(annualSigns[item]!.annualSign)Circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .shadow(radius: 5)
                            Text(annualSigns[item]!.annualSign.rawValue)
                                .font(.caption)
                                .foregroundColor(.black)
                        }
                        .padding(10)
                    }
                }
            }
            Text(shownPsychologicalStruct.text)
                .foregroundColor(.secondary)
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
            ScrollView {
                Text("Что такое психологическая структура?")
                    .font(.headline)
                    .bold()
                    .padding(.bottom)
                Text("Означенная структура дает ответы на два главных вопроса: как вести себя на бытовом уровне, то есть проявить себя в самых простых и естественных для человека условиях? Таким образом, в плане психологии человек не так уж далеко уходит от статуса животного. Второй вопрос и второй ответ: каковы физиологические особенности человека, что скрывает человек за внешней маской? Ибо все дело в том, что данная структура описывает именно те качества человека, которые тот хотел бы скрыть. Эдакие интимные подробности психологии.\n\nМожет именно из-за интимности психологических качеств, так называемая классическая наука аналогов данных качеств не обнаружила.\n\nПсихология в создании полного портрета человека имеет самый маленький удельный вес. Достаточно большое количество людей вообще не активизируют свою психологию, предпочитая выпячивать и развивать в себе совершенно иные качества. Иногда психологические качества человека уходят на уровень чистой физиологии, не затрагивая его умственную деятельность. Но даже если психология проявляется достаточно сильно, она, как правило, маскируется, причем маскируется по принципу дополнительности. То есть мужественные знаки стараются выглядеть нежно и демонстративно проявляют сентиментальность. Нежные знаки стараются выглядеть достаточно сурово и мужественно. Мечтатели хотят казаться деятельными и мастеровитыми, в свою очередь деятельный человек мечтает показаться человеком отвлеченным и не от мира сего. Так что, даже разгадав психологию человека, стоит считать ее делом интимным и тщательно скрываемым. Может именно из-за интимности психологических качеств, так называемая классическая наука аналогов данных качеств не обнаружила.")
                    .foregroundColor(.secondary)
            }
        }
        .padding()
    }
}
