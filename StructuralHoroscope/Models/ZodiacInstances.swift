//
//  ZodiacInstances.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 14.05.2023.
//

import Foundation


let zodiacArray: [ZodiacStruct] = [ariesStruct, taurusStruct, geminiStruct, cancerStruct, leoStruct, virgoStruct, libraStruct, scorpioStruct, sagittariusStruct, capricornStruct, aquariusStruct, piscesStruct]

//Aries—March 21-April 19
let ariesStruct = ZodiacStruct(
    sign: .aries,
    days: [3: 21...31, 4: 1...19]
)

//Taurus—April 20-May 20
let taurusStruct = ZodiacStruct(
    sign: .taurus,
    days: [4: 20...30, 5: 1...20]
)

//Gemini—May 21-June 20
let geminiStruct = ZodiacStruct(
    sign: .gemini,
    days: [5: 21...31, 6: 1...20]
)

//Cancer—June 21-July 22
let cancerStruct = ZodiacStruct(
    sign: .cancer,
    days: [6: 21...30, 7: 1...22]
)

//Leo—July 23-August 22
let leoStruct = ZodiacStruct(
    sign: .leo,
    days: [7: 23...31, 8: 1...22]
)

//Virgo—August 23-September 22
let virgoStruct = ZodiacStruct(
    sign: .virgo,
    days: [8: 23...31, 9: 1...22]
)

//Libra—September 23-October 22
let libraStruct = ZodiacStruct(
    sign: .libra,
    days: [9: 23...30, 10: 1...22]
)

//Scorpio—October 23-November 21
let scorpioStruct = ZodiacStruct(
    sign: .scorpio,
    days: [10: 23...31, 11: 1...21]
)

//Sagittarius—November 22-December 21
let sagittariusStruct = ZodiacStruct(
    sign: .sagittarius,
    days: [11: 22...30, 12: 1...21]
)

//Capricorn—December 22-January 19
let capricornStruct = ZodiacStruct(
    sign: .capricorn,
    days: [12: 22...31, 1: 1...19]
)

//Aquarius—Jan 20-Feb 18
let aquariusStruct = ZodiacStruct(
    sign: .aquarius,
    days: [1: 20...31, 2: 1...18]
)

//Pisces—Feb 19-March 20
let piscesStruct = ZodiacStruct(
    sign: .pisces,
    days: [2: 19...29, 3: 1...20]
)
