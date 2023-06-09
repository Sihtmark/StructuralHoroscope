import SwiftUI

struct AgeView: View {
    
    let ageStruct: AgeStruct
    @EnvironmentObject private var VM: ViewModel
    @State private var showFullDescription1 = false
    @State private var selection: Tab = .featured
    @State private var showDescription = false
    
    enum Tab {
        case featured
        case list
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                textPicker
                    .padding(.top)
                if selection == .featured {
                    textSection
                } else {
                    ageСommandmentsSection
                }
            }
        }
        .ignoresSafeArea(edges: .bottom)
        .frame(maxWidth: 900)
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

struct AgeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AgeView(ageStruct: bullAge)
                .preferredColorScheme(.dark)
        }
        .environmentObject(ViewModel())
        NavigationStack {
            AgeView(ageStruct: bullAge)
                .preferredColorScheme(.light)
        }
        .environmentObject(ViewModel())
    }
}

extension AgeView {
    
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
                .foregroundColor(.theme.standard)
                .font(.headline)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.bottom)
            Text(ageStruct.text)
                .foregroundColor(.theme.secondaryText)
        }
    }
    
    var ageСommandmentsSection: some View {
        VStack {
            Text(ageStruct.ageTitle)
                .foregroundColor(.theme.standard)
                .font(.headline)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.bottom)
            Text(ageStruct.ageСommandments)
                .foregroundColor(.theme.secondaryText)
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
                    .foregroundColor(.theme.standard)
                    .font(.headline)
                    .bold()
                    .padding(.bottom)
                Text("Эта стpуктуpа - возpастная, она устанавливает соответствие двенадцати знаков двенадцати возpастам жизни человека. У каждого возpаста свои особенности, и понять, объяснить их помогают свойства знака, котоpому он соответствует. В человеке 12 возpастных пpогpамм, каждая из них ждет своего часа и включается в положенный сpок. Hо одна из этих пpогpамм - в зависимости от года pождения - включена всю жизнь. Этот свой пожизненный возpастной знак человек должен знать и учитывать. Хотим обpатить внимание читателей на шиpокий диапазон чисто пpактических следствий, котоpые пpоистекают из знания возpастного гоpоскопа. Читайте и учитывайте! Возможно, вы еще пpиблизитесь к пониманию самого себя.")
                    .foregroundColor(.theme.secondaryText)
                Spacer()
            }
        }
        .padding()
    }
}
