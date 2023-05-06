//
//  CalendarInstances.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 05.05.2023.
//

import Foundation

let firstDay = DayStruct(
    date: Date().diff(numDays: 0),
    signs: [
        .rat: .rest,
        .bull: .red,
        .tiger: .blue,
        .cat: .orange,
        .dragon: .rest,
        .snake: .harder,
        .horse: .hangOut,
        .goat: .easier,
        .monkey: .rest,
        .rooster: .green,
        .dog: .yellow,
        .pig: .rest
    ]
)

let secondDay = DayStruct(
    date: Date().diff(numDays: 1),
    signs: [
        .rat: .harder,
        .bull: .blue,
        .tiger: .easier,
        .cat: .green,
        .dragon: .orange,
        .snake: .hangOut,
        .horse: .easier,
        .goat: .rest,
        .monkey: .harder,
        .rooster: .yellow,
        .dog: .red,
        .pig: .rest
    ]
)

let thirdDay = DayStruct(
    date: Date().diff(numDays: 2),
    signs: [
        .rat: .red,
        .bull: .easier,
        .tiger: .rest,
        .cat: .harder,
        .dragon: .hangOut,
        .snake: .green,
        .horse: .blue,
        .goat: .orange,
        .monkey: .yellow,
        .rooster: .easier,
        .dog: .rest,
        .pig: .harder
    ]
)

let fourthDay = DayStruct(
    date: Date().diff(numDays: 3),
    signs: [
        .rat: .easier,
        .bull: .orange,
        .tiger: .green,
        .cat: .hangOut,
        .dragon: .easier,
        .snake: .red,
        .horse: .harder,
        .goat: .yellow,
        .monkey: .blue,
        .rooster: .rest,
        .dog: .harder,
        .pig: .hangOut
    ]
)

let fifthDay = DayStruct(
    date: Date().diff(numDays: 4),
    signs: [
        .rat: .green,
        .bull: .harder,
        .tiger: .hangOut,
        .cat: .easier,
        .dragon: .blue,
        .snake: .harder,
        .horse: .yellow,
        .goat: .easier,
        .monkey: .orange,
        .rooster: .harder,
        .dog: .hangOut,
        .pig: .red
    ]
)

let sixthDay = DayStruct(
    date: Date().diff(numDays: 5),
    signs: [
        .rat: .blue,
        .bull: .hangOut,
        .tiger: .orange,
        .cat: .rest,
        .dragon: .harder,
        .snake: .yellow,
        .horse: .easier,
        .goat: .green,
        .monkey: .red,
        .rooster: .hangOut,
        .dog: .easier,
        .pig: .rest
    ]
)

let seventhDay = DayStruct(
    date: Date().diff(numDays: 6),
    signs: [
        .rat: .hangOut,
        .bull: .easier,
        .tiger: .rest,
        .cat: .red,
        .dragon: .yellow,
        .snake: .easier,
        .horse: .orange,
        .goat: .harder,
        .monkey: .hangOut,
        .rooster: .blue,
        .dog: .rest,
        .pig: .green
    ]
)

let eighthDay = DayStruct(
    date: Date().diff(numDays: 7),
    signs: [
        .rat: .easier,
        .bull: .rest,
        .tiger: .harder,
        .cat: .yellow,
        .dragon: .green,
        .snake: .rest,
        .horse: .harder,
        .goat: .hangOut,
        .monkey: .easier,
        .rooster: .red,
        .dog: .blue,
        .pig: .orange
    ]
)

let ninthDay = DayStruct(
    date: Date().diff(numDays: 8),
    signs: [
        .rat: .rest,
        .bull: .green,
        .tiger: .yellow,
        .cat: .easier,
        .dragon: .rest,
        .snake: .blue,
        .horse: .hangOut,
        .goat: .red,
        .monkey: .rest,
        .rooster: .harder,
        .dog: .orange,
        .pig: .easier
    ]
)

let tenthDay = DayStruct(
    date: Date().diff(numDays: 9),
    signs: [
        .rat: .harder,
        .bull: .yellow,
        .tiger: .red,
        .cat: .rest,
        .dragon: .harder,
        .snake: .hangOut,
        .horse: .easier,
        .goat: .blue,
        .monkey: .harder,
        .rooster: .orange,
        .dog: .green,
        .pig: .rest
    ]
)

let eleventhDay = DayStruct(
    date: Date().diff(numDays: 10),
    signs: [
        .rat: .yellow,
        .bull: .easier,
        .tiger: .rest,
        .cat: .harder,
        .dragon: .hangOut,
        .horse: .red,
        .snake: .orange,
        .goat: .harder,
        .monkey: .green,
        .rooster: .easier,
        .dog: .rest,
        .pig: .blue
    ]
)

let twelveDay = DayStruct(
    date: Date().diff(numDays: 11),
    signs: [
        .rat: .orange,
        .bull: .rest,
        .tiger: .harder,
        .cat: .blue,
        .dragon: .red,
        .snake: .rest,
        .horse: .green,
        .goat: .hangOut,
        .monkey: .easier,
        .rooster: .rest,
        .dog: .harder,
        .pig: .yellow
    ]
)
