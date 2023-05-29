//
//  BusinessInstances.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 19.04.2023.
//

import Foundation

let businessSigns: [BusinessEnum:BusinessStruct] = [.vectorHost: vectorHost, .vectorServant: vectorServant, .clone: clone, .companion: companion, .subordinate: subordinate, .adviser: adviser]

let businessArray = [vectorHost, vectorServant, clone, companion, subordinate, adviser]

let vectorHost = BusinessStruct(
    type: .vectorHost,
    value: "Активный риск",
    text: "Эти звенья непредсказуемые, поэтому их должно быть мало, иначе пирамиду растрясет. Особенно опасно в коллективе иметь векторного хозяина начальника, вольно или невольно он будет подрывать авторитет первой фигуры. И все же Вектор нужен, особенно когда дело требует скорости, быстрого обмена информацией. Иногда начальника с Вектором связывает искренняя и преданная дружба. Однако кто и где сказал, что друзья должны работать в одном деле? Это тем более опасно, что связано с какими-то избыточными иллюзиями. Приговор однозначен: векторного хозяина по службе не продвигать",
    signs: [
        .rat: [monkeySign],
        .bull: [dogSign],
        .tiger: [bullSign],
        .cat: [dragonSign],
        .dragon: [boarSign],
        .snake: [goatSign],
        .horse: [ratSign],
        .goat: [tigerSign],
        .monkey: [snakeSign],
        .rooster: [catSign],
        .dog: [roosterSign],
        .boar: [horseSign]
    ]
)

let vectorServant = BusinessStruct(
    type: .vectorServant,
    value: "Активный риск",
    text: "Эти звенья непредсказуемые, поэтому их должно быть мало, иначе пирамиду растрясет. Бесконечно увлекаться слугами не стоит. И все же Вектор нужен, особенно когда дело требует скорости, быстрого обмена информацией. Иногда начальника с Вектором связывает искренняя и преданная дружба. Однако кто и где сказал, что друзья должны работать в одном деле? Это тем более опасно, что связано с какими-то избыточными иллюзиями. Приговор однозначен: векторных слуг числом ограничить, оставив нескольких самых преданных.",
    signs: [
        .rat: [horseSign],
        .bull: [tigerSign],
        .tiger: [goatSign],
        .cat: [roosterSign],
        .dragon: [catSign],
        .snake: [monkeySign],
        .horse: [boarSign],
        .goat: [snakeSign],
        .monkey: [ratSign],
        .rooster: [dogSign],
        .dog: [bullSign],
        .boar: [dragonSign]
    ]
)

let clone = BusinessStruct(
    type: .clone,
    value: "Нужны только при становлении дела",
    text: "Клоны - это представители того же знака либо соседи по одной и той же тройке судьбы. На начальном этапе клонов может быть много, но по мере устройства пирамиды Клоны должны уходить. Эта категория служащих со временем, когда будет пройден период становления дела, должна быть самой малочисленной. Если же Клона удалить невозможно, то необходимо отвести его от себя в пространстве или во времени. Дать Клону возможность возглавить филиал или какое-то параллельное направление и в дальнейшем уменьшить время контактов.",
    signs: [
        .rat: [ratSign, tigerSign, dogSign],
        .bull: [bullSign, catSign, snakeSign],
        .tiger: [tigerSign, dogSign, ratSign],
        .cat: [catSign, snakeSign, bullSign],
        .dragon: [dragonSign, monkeySign, horseSign],
        .snake: [snakeSign, bullSign, catSign],
        .horse: [horseSign, monkeySign, dragonSign],
        .goat: [goatSign, boarSign, roosterSign],
        .monkey: [monkeySign, dragonSign, horseSign],
        .rooster: [roosterSign, goatSign, boarSign],
        .dog: [dogSign, tigerSign, ratSign],
        .boar: [boarSign, goatSign, roosterSign]
    ]
)

let companion = BusinessStruct(
    type: .companion,
    value: "Нужны обязательно, но в ограниченном количестве",
    text: "Соратники - знаки сопряжённой характеристики в структуре судьбы. В чётных знаках (чётные годы) сопряжены фаталисты и самодельщики, в нечётных - пионеры и фортунщики. Без Соратников никак нельзя, но и они по мере построения коллектива должны количественно уменьшаться. В конечном варианте надо оставить одного-двух соратников.Совсем без Соратника оставаться нельзя, ибо возникает неполноценность в судьбе",
    signs: [
        .rat: [dragonSign],
        .bull: [roosterSign, goatSign, boarSign],
        .tiger: [horseSign, monkeySign, dragonSign],
        .cat: [goatSign, boarSign],
        .dragon: [tigerSign, dogSign, ratSign],
        .snake: [roosterSign, boarSign],
        .horse: [tigerSign, dogSign],
        .goat: [catSign, bullSign],
        .monkey: [tigerSign, dogSign],
        .rooster: [snakeSign, bullSign],
        .dog: [monkeySign, dragonSign, horseSign],
        .boar: [snakeSign, bullSign, catSign]
    ]
)

let subordinate = BusinessStruct(
    type: .subordinate,
    value: "Нужны обязательно. Чем больше, тем лучше",
    text: "Подчиненные - это группа знаков из идеологической структуры по кругу подчинения. Волевики (Тигр, Лошадь, Собака) подчиняются реалистам (Коза, Кабан, Кот), те в свою очередь подчинены мистикам (Обезьяна, Крыса, Дракон), а мистики состоят в услужении у логиков (Петух, Змея, Бык), которые подчиняются волевикам. Круг замкнулся. Разумеется, все это минус векторные пары. Подчиненных должно быть много. Это главные работники, основная масса. В начале создания коллектива соратников должно быть мало, ибо они не столь инициативны как надо. Но по мере укрепления дела число подчиненных может увеличиваться многократно. Единственное за чем надо следить, так это за тем, чтобы те, кого мы назвали Подчиненными, подчинялись именно начальнику, а не Клону, или Соратнику.",
    signs: [
        .rat: [goatSign, catSign, boarSign],
        .bull: [ratSign, monkeySign, dragonSign],
        .tiger: [roosterSign, snakeSign],
        .cat: [horseSign, tigerSign, dogSign],
        .dragon: [goatSign],
        .snake: [ratSign, dragonSign],
        .horse: [roosterSign, bullSign, snakeSign],
        .goat: [horseSign, dogSign],
        .monkey: [goatSign, catSign, boarSign],
        .rooster: [dragonSign, ratSign, monkeySign],
        .dog: [snakeSign],
        .boar: [tigerSign, dogSign]
    ]
)

let adviser = BusinessStruct(
    type: .adviser,
    value: "Нужны в ограниченном количестве и без полномочий",
    text: "Советники - это подчиненные наоборот. Авторитет начальника поддерживать не будут, реальными полномочиями их нельзя нагружать. Пусть себе критикуют или советуют, но реально влиять на принятие решений им давать нельзя.",
    signs: [
        .rat: [roosterSign, snakeSign, bullSign],
        .bull: [horseSign],
        .tiger: [catSign, boarSign],
        .cat: [ratSign, monkeySign],
        .dragon: [roosterSign, snakeSign, bullSign],
        .snake: [horseSign, dogSign, tigerSign],
        .horse: [goatSign, catSign],
        .goat: [monkeySign, ratSign, dragonSign],
        .monkey: [roosterSign, bullSign],
        .rooster: [horseSign, tigerSign],
        .dog: [goatSign, catSign, boarSign],
        .boar: [monkeySign, ratSign]
    ]
)
