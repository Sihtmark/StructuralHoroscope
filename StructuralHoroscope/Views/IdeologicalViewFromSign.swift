//
//  IdeologicalViewFromSign.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 21.04.2023.
//

import SwiftUI

struct IdeologicalViewFromSign: View {
    
    @EnvironmentObject private var VM: ViewModel
    @State private var showFullDescription = false
    @State private var showFullDescription1 = false
    @State private var showFullDescription2 = false
    let sign: SignStruct
    
    var body: some View {
        ScrollView {
            ideologicInfoSection
            maleSection
            femaleSection
            signsSection
        }
        .padding(.horizontal)
        .navigationTitle("")
    }
}

struct IdeologicalSignViewFromSign_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            IdeologicalViewFromSign(sign: sampleClient.sign)
        }
        .environmentObject(ViewModel())
    }
}

extension IdeologicalViewFromSign {
    
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
        .padding(.top, 40)
    }
    
    var maleSection: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(sign.ideologicalType[.male]!.title)
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
            Text(sign.ideologicalType[.male]!.text)
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
        .padding(.top, 40)
    }
    
    var femaleSection: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(sign.ideologicalType[.female]!.title)
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
            Text(sign.ideologicalType[.female]!.text)
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
        }
        .padding(.top, 40)
    }
    
    var signsSection: some View {
        VStack {
            HStack {
                Text("Знаки:")
                    .font(.headline)
                Spacer()
            }
            .padding(.top, 40)
            ForEach(VM.ideologicalSigns(ideologicalEnum: sign.ideologicalType[.male]!.ideologicalType)) { sign in
                NavigationLink {
                    AnnualSignView(sign: sign)
                } label: {
                    HStack {
                        Text(sign.annualSign.rawValue)
                            .font(.title3)
                            .padding(5)
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                }
            }
        }
    }
}
