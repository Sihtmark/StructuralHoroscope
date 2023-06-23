import SwiftUI

struct SocialStructView: View {
    
    @EnvironmentObject private var vm: ViewModel
    @State private var showDescription = false
    @State private var shownStruct: SocialStruct = openedSocialStruct
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            picker
            infoSection
        }
        .frame(maxWidth: 900)
        .padding(.horizontal)
        .navigationTitle("Социальная структура")
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
            vectorDescription
                .presentationDragIndicator(.visible)
                .ignoresSafeArea(edges: .bottom)
        }
    }
}

struct SocialStructView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SocialStructView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(ViewModel())
        NavigationStack {
            SocialStructView()
                .preferredColorScheme(.light)
        }
        .environmentObject(ViewModel())
    }
}

extension SocialStructView {
    var picker: some View {
        Picker("asdf", selection: $shownStruct) {
            ForEach(socialArray) { item in
                Text(item.socialType.rawValue).tag(item)
            }
        }
    }
    
    var infoSection: some View {
        VStack {
            HStack {
                ForEach(shownStruct.signs, id: \.self) { item in
                    NavigationLink {
                        AnnualSignView(sign: annualSigns[item]!)
                    } label: {
                        VStack {
                            Image("\(annualSigns[item]!.annualSign)Circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .shadow(radius: 5)
                        }
                        .padding(10)
                    }
                }
            }
            Text(shownStruct.title)
                .foregroundColor(.theme.standard)
                .font(.headline)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.bottom)
            Text(shownStruct.text)
                .foregroundColor(.theme.secondaryText)
        }
    }
    
    var vectorDescription: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                Text("Что такое социальная структура?")
                    .foregroundColor(.theme.standard)
                    .font(.headline)
                    .bold()
                    .padding(.bottom)
                Text("Социальная структура объясняет как взаимодействует человек с пространством (сжимается, растекается или желает сохранить сферу обитания стабильной). И второе: как относиться к обществу, быть выше его, подчиняться его запросам, либо быть с ним заодно.\n\nОбщение человека или говоря по-научному социальная и пространственная ориентация, отсылают нас к то ли к социологии, то ли к юнговской соционической доктрине, которые чрезвычайно переоценивают момент общения. На самом же деле социальная ориентация не имеет слишком ярких внешних проявлений, действует в ограниченном спектре творческих занятий. Кроме того, социальность знаков разная на Востоке, на Западе и в государствах с имперским ритмом. Но при всех этих оговорках общение важнее психологии, что само по себе уже не мало.\n\nКлассические наименования введены Юнгом и хорошо известны: интроверт и экстраверт. Однако Юнг прозевал третий вариант - ортодокс. Интроверты, - закрытые знаки, экстраверты - открытые. Ортодоксы - те, кто охраняют ограниченную территорию, стабильность своего положения.")
                    .foregroundColor(.theme.secondaryText)
            }
            .padding()
            .padding(.vertical)
        }
    }
}
