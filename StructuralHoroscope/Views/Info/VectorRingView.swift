//
//  VectorRingView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 29.04.2023.
//

import SwiftUI

struct VectorRingView: View {
    
    @EnvironmentObject private var vm: ViewModel
    @State private var showFullDescription = false
    
    var body: some View {
        ScrollView {
            infoSection
            signsSection
        }
        .navigationTitle("Векторные пары")
    }
}

struct VectorRingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            VectorRingView()
        }
        .environmentObject(ViewModel())
    }
}

extension VectorRingView {
    var infoSection: some View {
        VStack(alignment: .leading) {
            Text("Иногда к структурам причисляется закольцованная последовательность знаков, получившая название векторного кольца. Смысл кольца в том, что у каждого знака есть два соседа, один именуется 'хозяином', другой 'слугой'. Несмотря на внешнюю простоту, кольцо весьма многозначно.\n\nВ данном случае оно будет представлено, как некая цепь перерождений человеческого духа, двенадцатью ступенями постижения мироздания.\n\nВ дополнение к проанализированному устройству знаков хотелось бы сказать об одной аномалии, существование которой неким скрытым и не ясным пока образом заложено в самом устройстве знаков.\n\nРечь идет о знаменитом Векторном кольце, кольцевой последовательности знаков, в которой два соседних знака образуют так называемую Векторную пару, где один знак играет роль энергетического донора (Слуги), а другой мощного похитителя энергии (Хозяина). Энергетический поток в такой паре может быть невероятно мощным и сумбурным, а последствия непредсказуемыми, иногда анекдотическими, иногда трагическими.\n\nДо тех пор, пока Векторные страсти остаются достоянием двух людей, все события остаются под относительным контролем. Однако бывает, что Векторный джин вырывается из бутылки интимного контакта и овладевает широким пространством. При этом энергия Вектора не уменьшается, а многократно возрастает, втягивая в свое движение огромные массы людей, иногда целые страны и даже человечество в целом.\n\nВ любом случае о существовании Векторного кольца надо знать и понимать, что любой человек находящийся в Векторном взаимодействии уже не совсем то, что описывается его знаком. По сути дела внутри Векторной пары образуется некий монстр, свойства которого заранее предсказать не возможно. Диапазон от невероятно жестокого преступного тандема, например, Бонни Паркер (Собака) и Клайд Бэрроу (Петух) до невероятно гениального творческого тандема, например, Илья Ильф (Петух) и Евгений Петров(Кот).\n\nПонять, как складывался данный порядок не легко, само кольцо было открыто эмпирическим путем. Единственная структура, связь с которой совершенно очевидна является тоже, в определенном смысле, загадочная структура Судьбы. Четыре группы знаков Судьбы имеют четкую систему взаимодействия через Векторные связи.\n\nВ данном списке на первом месте в паре - Слуга, на втором - Хозяин.")
                .foregroundColor(.secondary)
                .lineLimit(showFullDescription ? nil : 2)
            Button {
                showFullDescription.toggle()
            } label: {
                Text(showFullDescription ? "Свернуть" : "Развернуть...")
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(.vertical, 4)
            }
            .accentColor(.blue)
        }
        .padding()
    }
    var signsSection: some View {
        VStack {
            HStack {
                Text("Хозяин")
                    .font(.title)
                    .bold()
                    .frame(width: 170, alignment: .leading)
                Text("Слуга")
                    .font(.title)
                    .bold()
                    .frame(width: 170, alignment: .leading)
                Divider()
            }
            ForEach(annualSignArray) { sign in
                VStack {
                    HStack {
                        NavigationLink {
                            AnnualSignView(sign: sign)
                        } label: {
                            Text(sign.annualSign.rawValue)
                                .font(.title)
                                .frame(width: 170, alignment: .leading)
                        }
                        NavigationLink {
                            AnnualSignView(sign: annualSigns[sign.vectorServant]!)
                        } label: {
                            Text(sign.vectorServant.rawValue)
                                .font(.title)
                                .frame(width: 170, alignment: .leading)
                        }
                    }
                }
            }
        }
    }
}
