import SwiftUI

struct SocialSignsView: View {
    @EnvironmentObject private var VM: ViewModel
    @State private var showVirtualSignDescription = false
    @State private var shownVirtualSign: SocialSignStruct = kingSign

    var body: some View {
        ScrollView(showsIndicators: false) {
            signsSection
            virtualSignSection
                .frame(maxWidth: 900)
                .padding()
        }
        .navigationTitle("Виртуальные знаки")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showVirtualSignDescription = true
                } label: {
                    Image(systemName: "info.circle")
                }
            }
        }
        .sheet(isPresented: $showVirtualSignDescription) {
            virtualSignDescription
                .presentationDragIndicator(.visible)
        }
    }
}

struct VirtualSignsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SocialSignsView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(ViewModel())
        NavigationStack {
            SocialSignsView()
                .preferredColorScheme(.light)
        }
        .environmentObject(ViewModel())
    }
}

extension SocialSignsView {
    var signsSection: some View {
        ScrollView {
            LazyVStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(socialSigns) { sign in
                            Button {
                                shownVirtualSign = sign
                            } label: {
                                HStack {
                                    Text(sign.emoji.rawValue)
                                    Text(sign.socialSign.rawValue)
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 10)
                                .background(
                                    ZStack {
                                        Capsule()
                                            .stroke(lineWidth: 0.4)
                                    }
                                )
                                .padding(10)
                            }
                        }
                    }
                }
            }
        }
    }

    var virtualSignSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("\(shownVirtualSign.emoji.rawValue) \(shownVirtualSign.socialSign.rawValue)")
                .foregroundColor(.theme.standard)
                .font(.title)
                .bold()
            ForEach(shownVirtualSign.blocks.sorted(by: <), id: \.key) { key, value in
                VStack(alignment: .leading) {
                    Text(key)
                        .foregroundColor(.theme.standard)
                        .font(.headline)
                    Text(value)
                        .foregroundColor(.theme.secondaryText)
                }
            }
        }
    }

    var virtualSignDescription: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                Text("О виртуальных знаках")
                    .foregroundColor(.theme.standard)
                    .font(.headline)
                    .bold()
                    .padding(.bottom)
                Text("Зодиакальный и восточный знаки остаются в человеке сами по себе, но рядом с ними появляется еще и третий знак, рожденный от их взаимодействия.\n\nЗодиакальный гороскоп - это здоровье, жизненные планы, амбиции, намерения, а также все характеристики человека в детстве (до 12 лет).\n\nВосточный (годовой) гороскоп - это типы мышления, типы творческой ориентации. Все что связано с поведением человека после 12 лет, в особенности же поведение в любви и браке. Ну и, конечно же, реализация тех самых планов и амбиций, что заложил в человеке зодиакальный знак.\n\nТретий гороскоп, рожденный в борьбе планов и реализации, показывает тип гармонии человека. Соответствие планов и реализации рождает высокую гармоничность, но делает человека менее активным. Слабое соответствие уменьшает гармонию, но увеличивает энергию. Так рождается образ человека, оптимальный имидж. Поскольку речь идет не о реальной сути человека, а только о его образе, создаваемой им картинки, то гороскоп получил название - Виртуальный гороскоп.\n\nЗнаков в новом Виртуальном гороскопе не 12 и не 144, а семь (Король, Вектор, Шут, Рыцарь, Аристократ, Профессор, Вождь). Все названия знаков, также как и описания определены экспериментально, в результате долгих исследований людей сумевших найти выгодный имидж и сделавший на этом карьеру, а также наиболее знаменитых кинообразов отечественного и мирового кино.")
                    .foregroundColor(.theme.secondaryText)
            }
            .padding()
            .padding(.vertical)
        }
    }
}
