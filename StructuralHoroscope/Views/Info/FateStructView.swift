import SwiftUI

struct FateStructView: View {
    @EnvironmentObject private var vm: ViewModel
    @State private var shownStruct: FateStruct = pioneerFateStruct

    var body: some View {
        ScrollView(showsIndicators: false) {
            picker
            infoSection
        }
        .frame(maxWidth: 550)
        .navigationTitle("Энергетическая структура")
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal)
    }
}

struct FateStructView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            FateStructView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(ViewModel())
        NavigationStack {
            FateStructView()
                .preferredColorScheme(.light)
        }
        .environmentObject(ViewModel())
    }
}

extension FateStructView {
    var picker: some View {
        Picker("asdf", selection: $shownStruct) {
            ForEach(fateArray) { item in
                Text(item.fateType.rawValue).tag(item)
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
}
