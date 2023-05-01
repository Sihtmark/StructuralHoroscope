//
//  AgeStructView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 01.05.2023.
//

import SwiftUI

struct AgeStructView: View {
    
    @EnvironmentObject private var vm: ViewModel
    @State private var showFullDescription1 = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 40) {
                Text("Возрастной гороскоп")
                    .font(.title)
                    .bold()
                businessInfo
                signsSection
            }
        }
        .padding(.horizontal)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AgeStructView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AgeStructView()
        }
        .environmentObject(ViewModel())
    }
}

extension AgeStructView {
    var businessInfo: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Что такое возрастной гороскоп")
                .font(.headline)
            Text("Эта стpуктуpа - возpастная, она устанавливает соответствие двенадцати знаков двенадцати возpастам жизни человека. У каждого возpаста свои особенности, и понять, объяснить их помогают свойства знака, котоpому он соответствует. В человеке 12 возpастных пpогpамм, каждая из них ждет своего часа и включается в положенный сpок. Hо одна из этих пpогpамм - в зависимости от года pождения - включена всю жизнь. Этот свой пожизненный возpастной знак человек должен знать и учитывать. Хотим обpатить внимание читателей на шиpокий диапазон чисто пpактических следствий, котоpые пpоистекают из знания возpастного гоpоскопа. Читайте и учитывайте! Возможно, вы еще пpиблизитесь к пониманию самого себя.")
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
            }
            .accentColor(.blue)
        }
    }
    var signsSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            ForEach(ages) { age in
                NavigationLink {
                    AgeView(age: age)
                } label: {
                    HStack {
                        Text(age.title)
                            .font(.title3)
                            .multilineTextAlignment(.leading)
                            .frame(width: 220, alignment: .leading)
                        Image(systemName: "chevron.right")
                    }
                }
            }
        }
    }
}
