//
//  IdeologicalStructView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 29.04.2023.
//

import SwiftUI

struct IdeologicalStructView: View {
    
    @EnvironmentObject private var vm: ViewModel
    @State private var showDescription = false
    @State private var shownStruct: IdeologicalStruct = mysticMale
    
    var body: some View {
        ScrollView {
            picker
            mainSection
        }
        .padding(.horizontal)
        .navigationTitle("Идеологическая структура")
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
            vectorDescription
        }
    }
}

struct IdeologicalStructView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            IdeologicalStructView()
        }
        .environmentObject(ViewModel())
    }
}

extension IdeologicalStructView {
    var picker: some View {
        Picker("asdf", selection: $shownStruct) {
            ForEach(ideologicalArray) { item in
                Text(item.ideologicalType.rawValue).tag(item)
            }
        }
    }
    
    var mainSection: some View {
        VStack {
            HStack {
                ForEach(shownStruct.signs, id: \.self) { item in
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
            Text(shownStruct.title)
                .font(.headline)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.bottom)
            Text(shownStruct.text)
                .foregroundColor(.secondary)
        }
    }
    
    var vectorDescription: some View {
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
                Text("Что такое идеологическая структура?")
                    .font(.headline)
                    .bold()
                    .padding(.bottom)
                Text("Вот и пришли мы к самому главному в человеке, - к его мышлению. Именно мышление отличает нас от животных. Наша, как нам кажется богатая психология, не делает нас еще человеком, ибо почти нацело физиологична. Наше общение, наша социальность - это уже шаг вперед, однако в этом шаге мы ушли от животного мира не очень далеко. Темперамент, энергетическое разнообразие, наличие собственного энергетического портрета делает нас существами нового типа, это решающий шаг к человеческой индивидуальности. Далее знак Судьбы. Тут мы уже оторвались от животного состояния, у животного нет предназначения, так же как нет его у человека пустого и бессмысленного. Только тот заслуживает звание человека, кто обрел свою Судьбу. И все же окончательный приговор выносит мышление. Только тот, кто может самостоятельно мыслить, преодолев наслоения родовых стереотипов, только тот человек.\n\nИдеологическая структура, без всяких сомнений, самая сильная, самая мощная. Ее характеристики, как приговор, как клеймо, которое нельзя смыть. От любой другой структуры можно увернуться, можно спрятать психологию, утаить темперамент, замести следы судьбы и извратить социальную ориентацию. Но от идеологической структуры не уйдешь. Она формирует тип мышления. А мыслить обязан каждый, кто надеется, что он человек.\n\nУдивительно, но именно в тот момент, когда человек становится Человеком, он тут же теряет свое единство, разделяясь на две ветви - женскую и мужскую. Причем различие в мышлении женщин и мужчин носит принципиальный характер. Мышление мужчин едино, языковой (образный) уровень идеально состыкован с самим типом мышления. В результате суммарное мышление мужчин носит активный творческий характер. У женщин языковой уровень находится в сильном противоречии с самим типом мышлением, в результате мы получаем мышление с трещиной. Следствием треснувшего мышления является резкое снижение творческого потенциала, но при этом столь же резкое повышается способность к восприятию чужих идей. Так мужчина получает возможность реализации быстрого творческого гения, а женщина получает возможность реализации медленного гения восприятия\n\nИтак: женский знак раздвоен. Внешне женский знак копирует мужской, что касается типа мышления, то он другой, от другой тройки знаков. Так у логических (по образу) знаков волевой тип мышления. У волевых (по образу) знаков логический тип мышления. У реалистических (по образу) знаков мистическое мышление. У мистиков (по образу) реалистический тип мышления.")
                    .foregroundColor(.secondary)
            }
        }
        .padding()
    }
}
