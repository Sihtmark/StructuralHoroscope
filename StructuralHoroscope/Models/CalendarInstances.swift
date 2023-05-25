//
//  CalendarInstances.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 05.05.2023.
//

import Foundation

let days = [firstDay, secondDay, thirdDay, fourthDay, fifthDay, sixthDay, seventhDay, eighthDay, ninthDay, tenthDay, eleventhDay, twelveDay]

let green = DayType(
    title: "Зеленый",
    emoji: "🟢",
    text: "Зеленый свет - полный газ, искать удачи, возможно все, рискуй, ищи высшего вдохновения!"
)

let red = DayType(
    title: "Красный",
    emoji: "🔴",
    text: "Красный свет - переломный день, ходу нет, надо каяться (только искренне!), просить прощения, улучшать карму"
)

let blue = DayType(
    title: "Синий",
    emoji: "🔵",
    text: "Синий - расслабление полнейшее, эйфория и самодовольство"
)

let yellow = DayType(
    title: "Желтый",
    emoji: "🟡",
    text: "Желтый свет - внимание, чудеса вполне возможны, напрягайся, будь готов!"
)

let orange = DayType(
    title: "Оранжевый",
    emoji: "🟠",
    text: "Оранжевый - максимальный полет фантазии, состояние без дна и берегов."
)

let easier = DayType(
    title: "Легче",
    emoji: "🙂",
    text: nil
)

let harder = DayType(
    title: "Труднее",
    emoji: "🙁",
    text: nil
)

let hangOut = DayType(
    title: "Потусуйтесь",
    emoji: "🥳",
    text: nil
)

let rest = DayType(
    title: "Отдых",
    emoji: "😴",
    text: nil
)

let firstDay: [AnnualEnum: DayType] = [
    .rat: easier,
    .bull: orange,
    .tiger: green,
    .cat: hangOut,
    .dragon: easier,
    .snake: red,
    .horse: harder,
    .goat: yellow,
    .monkey: blue,
    .rooster: rest,
    .dog: harder,
    .boar: hangOut
]

let secondDay: [AnnualEnum: DayType] = [
    .rat: green,
    .bull: harder,
    .tiger: hangOut,
    .cat: easier,
    .dragon: blue,
    .snake: harder,
    .horse: yellow,
    .goat: easier,
    .monkey: orange,
    .rooster: harder,
    .dog: hangOut,
    .boar: red
]

let thirdDay: [AnnualEnum: DayType] = [
    .rat: blue,
    .bull: hangOut,
    .tiger: orange,
    .cat: rest,
    .dragon: harder,
    .snake: yellow,
    .horse: easier,
    .goat: green,
    .monkey: red,
    .rooster: hangOut,
    .dog: easier,
    .boar: rest
]

let fourthDay: [AnnualEnum: DayType] = [
    .rat: hangOut,
    .bull: easier,
    .tiger: rest,
    .cat: red,
    .dragon: yellow,
    .snake: easier,
    .horse: orange,
    .goat: harder,
    .monkey: hangOut,
    .rooster: blue,
    .dog: rest,
    .boar: green
]

let fifthDay: [AnnualEnum: DayType] = [
    .rat: easier,
    .bull: rest,
    .tiger: harder,
    .cat: yellow,
    .dragon: green,
    .snake: rest,
    .horse: harder,
    .goat: hangOut,
    .monkey: easier,
    .rooster: red,
    .dog: blue,
    .boar: orange
]

let sixthDay: [AnnualEnum: DayType] = [
    .rat: rest,
    .bull: green,
    .tiger: yellow,
    .cat: easier,
    .dragon: rest,
    .snake: blue,
    .horse: hangOut,
    .goat: red,
    .monkey: rest,
    .rooster: harder,
    .dog: orange,
    .boar: easier
]

let seventhDay: [AnnualEnum: DayType] = [
    .rat: harder,
    .bull: yellow,
    .tiger: red,
    .cat: rest,
    .dragon: harder,
    .snake: hangOut,
    .horse: easier,
    .goat: blue,
    .monkey: harder,
    .rooster: orange,
    .dog: green,
    .boar: rest
]

let eighthDay: [AnnualEnum: DayType] = [
    .rat: yellow,
    .bull: easier,
    .tiger: rest,
    .cat: harder,
    .dragon: hangOut,
    .horse: red,
    .snake: orange,
    .goat: harder,
    .monkey: green,
    .rooster: easier,
    .dog: rest,
    .boar: blue
]

let ninthDay: [AnnualEnum: DayType] = [
    .rat: orange,
    .bull: rest,
    .tiger: harder,
    .cat: blue,
    .dragon: red,
    .snake: rest,
    .horse: green,
    .goat: hangOut,
    .monkey: easier,
    .rooster: rest,
    .dog: harder,
    .boar: yellow
]


let tenthDay: [AnnualEnum: DayType] = [
    .rat: rest,
    .bull: red,
    .tiger: blue,
    .cat: orange,
    .dragon: rest,
    .snake: harder,
    .horse: hangOut,
    .goat: easier,
    .monkey: rest,
    .rooster: green,
    .dog: yellow,
    .boar: rest
]

let eleventhDay: [AnnualEnum: DayType] = [
    .rat: harder,
    .bull: blue,
    .tiger: easier,
    .cat: green,
    .dragon: orange,
    .snake: hangOut,
    .horse: easier,
    .goat: rest,
    .monkey: harder,
    .rooster: yellow,
    .dog: red,
    .boar: rest
]

let twelveDay: [AnnualEnum: DayType] = [
    .rat: red,
    .bull: easier,
    .tiger: rest,
    .cat: harder,
    .dragon: hangOut,
    .snake: green,
    .horse: blue,
    .goat: orange,
    .monkey: yellow,
    .rooster: easier,
    .dog: rest,
    .boar: harder
]
