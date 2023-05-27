//
//  Color.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 15.05.2023.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
    static let launch = LaunchTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let standard = Color("Standard")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
}

struct ColorTheme2 {
    let accent = Color("AccentColor2")
    let background = Color("BackgroundColor2")
    let green = Color("GreenColor2")
    let red = Color("RedColor2")
    let secondaryText = Color("SecondaryTextColor2")
}

struct LaunchTheme {
    let accent = Color("LaunchAccentColor")
    let background = Color("LaunchBackgroundColor")
}
