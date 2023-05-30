//
//  InfoCalendarView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 26.05.2023.
//

import SwiftUI

struct InfoCalendarView: View {
    var body: some View {
        VStack {
            List {
                Section {
                    ForEach(coloredDays, id: \.self) { day in
                        VStack(alignment: .leading, spacing: 10) {
                            HStack(spacing: 10) {
                                HStack(spacing: 10) {
                                    Text(day.emoji)
                                    Text(day.title)
                                        .foregroundColor(.theme.standard)
                                }
                            }
                            if let text = day.text {
                                Text(text)
                                    .font(.caption)
                                    .bold()
                                    .foregroundColor(.theme.secondaryText)
                            }
                        }
                        .listRowSeparator(.hidden)
                    }
                } header: {
                    Text("Дни сердца:")
                        .foregroundColor(.theme.accent)
                        .font(.headline)
                } footer: {
                    Text("Цветной круг - здесь разум надо отключить и дать поработать сердцу (душе)")
                        .foregroundColor(.theme.secondaryText)
                        .font(.callout)
                }
                Section {
                    ForEach(mindDays, id: \.self) { day in
                        HStack(spacing: 10) {
                            Text(day.emoji)
                            Text(day.title)
                                .foregroundColor(.theme.standard)
                        }
                        .listRowSeparator(.hidden)
                    }
                } header: {
                    Text("Дни разума:")
                        .foregroundColor(.theme.accent)
                        .font(.headline)
                } footer: {
                    Text("Emoji - это сигнал к тому, чтобы прожить день спокойно, благоразумно, по четко разработанному плану")
                        .foregroundColor(.theme.secondaryText)
                        .font(.callout)
                }
                Section {
                    Text(dayTypeInfo)
                        .foregroundColor(.theme.secondaryText)
                        .font(.callout)
                        .listRowSeparator(.hidden)
                } header: {
                    HStack {
                        Spacer()
                        Text("Найди свой день удачи")
                            .foregroundColor(.theme.standard)
                            .font(.headline)
                            .bold()
                            .padding(.bottom)
                        Spacer()
                    }
                }
                
            }
            .listStyle(.inset)
            .scrollIndicators(ScrollIndicatorVisibility.hidden)
        }
    }
}

struct InfoCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        InfoCalendarView()
            .preferredColorScheme(.dark)
        InfoCalendarView()
            .preferredColorScheme(.light)
    }
}
