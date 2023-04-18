//
//  IdeologicalSignView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 15.04.2023.
//

import SwiftUI

struct IdeologicalView: View {
    
    @EnvironmentObject private var VM: ViewModel
    @State private var showFullDescription = false
    @State private var showFullDescription1 = false
    @State private var showFullDescription2 = false
    let customer: ClientStruct
    
    var body: some View {
        ScrollView {
            ideologicInfoSection
            infoSection
            signsSection
        }
        .padding(.horizontal)
        .navigationTitle(customer.sign.ideologicalType[customer.sex]!.ideologicalType.rawValue)
    }
}

struct IdeologicalSignView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            IdeologicalView(customer: sampleClient)
        }
        .environmentObject(ViewModel())
    }
}

extension IdeologicalView {
    
    var ideologicInfoSection: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Идеологическая структура")
                    .font(.headline)
                Spacer()
                Button {
                    showFullDescription.toggle()
                } label: {
                    withAnimation {
                        Image(systemName: showFullDescription ? "chevron.up" : "chevron.down")
                    }
                }
            }.padding(.bottom, 5)
                .padding(.top, 30)
            Text("Вот и пришли мы к самому главному в человеке, - к его мышлению. Именно мышление отличает нас от животных. Наша, как нам кажется богатая психология, не делает нас еще человеком, ибо почти нацело физиологична. Наше общение, наша социальность - это уже шаг вперед, однако в этом шаге мы ушли от животного мира не очень далеко. Темперамент, энергетическое разнообразие, наличие собственного энергетического портрета делает нас существами нового типа, это решающий шаг к человеческой индивидуальности. Далее знак Судьбы. Тут мы уже оторвались от животного состояния, у животного нет предназначения, так же как нет его у человека пустого и бессмысленного. Только тот заслуживает звание человека, кто обрел свою Судьбу. И все же окончательный приговор выносит мышление. Только тот, кто может самостоятельно мыслить, преодолев наслоения родовых стереотипов, только тот человек.\n\nИдеологическая структура, без всяких сомнений, самая сильная, самая мощная. Ее характеристики, как приговор, как клеймо, которое нельзя смыть. От любой другой структуры можно увернуться, можно спрятать психологию, утаить темперамент, замести следы судьбы и извратить социальную ориентацию. Но от идеологической структуры не уйдешь. Она формирует тип мышления. А мыслить обязан каждый, кто надеется, что он человек.\n\nУдивительно, но именно в тот момент, когда человек становится Человеком, он тут же теряет свое единство, разделяясь на две ветви - женскую и мужскую. Причем различие в мышлении женщин и мужчин носит принципиальный характер. Мышление мужчин едино, языковой (образный) уровень идеально состыкован с самим типом мышления. В результате суммарное мышление мужчин носит активный творческий характер. У женщин языковой уровень находится в сильном противоречии с самим типом мышлением, в результате мы получаем мышление с трещиной. Следствием треснувшего мышления является резкое снижение творческого потенциала, но при этом столь же резкое повышается способность к восприятию чужих идей. Так мужчина получает возможность реализации быстрого творческого гения, а женщина получает возможность реализации медленного гения восприятия\n\nИтак: женский знак раздвоен. Внешне женский знак копирует мужской, что касается типа мышления, то он другой, от другой тройки знаков. Так у логических (по образу) знаков волевой тип мышления. У волевых (по образу) знаков логический тип мышления. У реалистических (по образу) знаков мистическое мышление. У мистиков (по образу) реалистический тип мышления.")
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
                    .padding(.vertical, 4)
            }
            .accentColor(.blue)
        }
    }
    
    var infoSection: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(customer.sign.ideologicalType[customer.sex]!.title[customer.sex]!)
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
            Text(customer.sign.ideologicalType[customer.sex]!.text[customer.sex]!)
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
        }
    }
    
    var signsSection: some View {
        ForEach(mysticMales) { sign in
            NavigationLink {
                AnnualSignInfo(sign: sign)
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
}
