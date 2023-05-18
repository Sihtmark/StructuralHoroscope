//
//  EnergyInstances.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 15.04.2023.
//

import Foundation

let dramaticSigns = [goatSign, ratSign, snakeSign]
let sanguineSigns = [bullSign, horseSign, boarSign]
let phlegmaticSigns = [tigerSign, roosterSign, dragonSign]
let melancholicSigns = [monkeySign, catSign, dogSign]

let energyStructs: [EnergyEnum: EnergyStruct] = [
    .dramatic: dramaticEnergeticStruct,
    .sanguine: sanguineEnergeticStruct,
    .phlegmatic: phlegmaticEnergyStruct,
    .melancholic: melancholicEnergyStruct
]

let energyArray = [dramaticEnergeticStruct, sanguineEnergeticStruct, phlegmaticEnergyStruct, melancholicEnergyStruct]

let dramaticEnergeticStruct = EnergyStruct(
    energyType: .dramatic,
    signs: [.goat, .rat, .snake],
    title: "Драматический темперамент (холерики)",
    text: "Источник энергии для этих знаков - это переживания, страсти, в том числе и любовные. Поэтому надо общаться с людьми, заворачивать жизненный сюжет покруче. Проявляется темперамент в том, что человек не знает середины, переходя от бешенного веселья к отчаянию. Драматизации подвергается любое событие, любое явление. При внешней бурности, запас энергии минимален, провал может наступить в любой момент."
)

let sanguineEnergeticStruct = EnergyStruct(
    energyType: .sanguine,
    signs: [.bull, .horse, .boar],
    title: "Природные оптимисты (сангвиники)",
    text: "Источником энергии является любое природное явление - восход, закат, дождь, снег, зной и даже ураган. А вот длительное участие в страстях человеческих приводит к энергетическому истощению. Чаще всего темперамент проявляется как устойчивый, уравновешенный, высока уверенность в себе, чувствуется большой запас сил. Впрочем за счет больших запасов энергии знаки могут изредка вспыхивать и наносить мощные удары."
)

let phlegmaticEnergyStruct = EnergyStruct(
    energyType: .phlegmatic,
    signs: [.tiger, .rooster, .dragon],
    title: "Космические оптимисты (флегматики)",
    text: "Источником энергии является тот самый пресловутый космос, наджизненное пространство, лишенное времени и суеты. Потому космические оптимисты так по-космически холодны и отстранены от страстей человеческих. Они верят во всеобщее торжество добра и справедливости. Внешние проявления от безразличия до высокомерной снисходительности. В идеале темперамент склоняет к философствованию."
)

let melancholicEnergyStruct = EnergyStruct(
    energyType: .melancholic,
    signs: [.monkey, .cat, .dog],
    title: "Скептики (меланхолики)",
    text: "Источником энергии для скептиков является умствование, интеллектуальная активность, софистика, казуистика, прочее головоломное переливание из пустого в порожнее. Скептицизм всегда умен, ум всегда скептичен. С одной стороны скептический темперамент склоняет к активной деятельности, ибо скептик всегда полон идей, с другой стороны он никогда не поверит своим же идеям до конца, а потому всегда готов к неудаче. К людям скептик относится скептически, во всеобщее счастье не верит, на мир людей смотрит с грустной улыбкой премудрого и много повидавшего в жизни старика."
)
