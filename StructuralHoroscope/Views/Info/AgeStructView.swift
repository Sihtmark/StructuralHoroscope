//
//  AgeStructView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 01.05.2023.
//

import SwiftUI

struct AgeStructView: View {
    
    @EnvironmentObject private var vm: ViewModel
    @State private var showDescription = false
    @State private var ageStruct: AgeStruct = roosterAge
    @State private var selection: Tab = .featured
    
    enum Tab {
        case featured
        case list
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                structPicker
                textPicker
                if selection == .featured {
                    textSection
                } else {
                    ageСommandmentsSection
                }
            }
        }
        .padding(.horizontal)
        .navigationTitle("Возрасты")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showDescription = true
                } label: {
                    Image(systemName: "info.circle")
                }
            }
        }
        .sheet(isPresented: $showDescription) {
            description
        }
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
    
    var structPicker: some View {
        Picker("asdf", selection: $ageStruct) {
            ForEach(ageArray) { item in
                Text(item.sign.rawValue).tag(item)
            }
        }
    }
    
    var textPicker: some View {
        Picker("asdf", selection: $selection) {
            Text("Особенности").tag(Tab.featured)
            Text("Заповеди").tag(Tab.list)
        }
        .pickerStyle(.segmented)
    }
    
    var textSection: some View {
        VStack {
            Text(ageStruct.title)
                .font(.headline)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.bottom)
            Text(ageStruct.text)
                .foregroundColor(.secondary)
        }
    }
    
    var ageСommandmentsSection: some View {
        VStack {
            Text(ageStruct.ageTitle)
                .font(.headline)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.bottom)
            Text(ageStruct.ageСommandments)
                .foregroundColor(.secondary)
        }
    }
    
    var description: some View {
        VStack {
            HStack {
                Button {
                    showDescription = false
                } label: {
                    Label("Назад", systemImage: "chevron.left")
                }
                Spacer()
            }
            .padding()
            VStack {
                Text("Что такое структура возрастов?")
                    .font(.headline)
                    .bold()
                    .padding(.bottom)
                Text("Эта стpуктуpа - возpастная, она устанавливает соответствие двенадцати знаков двенадцати возpастам жизни человека. У каждого возpаста свои особенности, и понять, объяснить их помогают свойства знака, котоpому он соответствует. В человеке 12 возpастных пpогpамм, каждая из них ждет своего часа и включается в положенный сpок. Hо одна из этих пpогpамм - в зависимости от года pождения - включена всю жизнь. Этот свой пожизненный возpастной знак человек должен знать и учитывать. Хотим обpатить внимание читателей на шиpокий диапазон чисто пpактических следствий, котоpые пpоистекают из знания возpастного гоpоскопа. Читайте и учитывайте! Возможно, вы еще пpиблизитесь к пониманию самого себя.")
                    .foregroundColor(.secondary)
                Spacer()
            }
        }
        .padding()
    }
}
