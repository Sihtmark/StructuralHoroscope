import SwiftUI

struct AnnualSignsView: View {
    @EnvironmentObject private var VM: ViewModel
    @State private var showFullDescription = false
    @State private var shownAnnualSign: AnnualSignStruct = ratSign

    var body: some View {
        VStack {
            annualSigns
            AnnualSignView(sign: shownAnnualSign)
        }
        .frame(maxWidth: 550)
        .navigationTitle("Годовые знаки")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AnnualSignsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AnnualSignsView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(ViewModel())
        NavigationStack {
            AnnualSignsView()
                .preferredColorScheme(.light)
        }
        .environmentObject(ViewModel())
    }
}

extension AnnualSignsView {
    var annualSigns: some View {
        LazyVStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(annualSignArray) { sign in
                        Button {
                            shownAnnualSign = sign
                        } label: {
                            VStack {
                                Image("\(sign.annualSign)Circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 55, height: 55)
                                    .shadow(radius: 5)
                            }
                            .padding(10)
                        }
                    }
                }
            }
        }
        .padding(.top, 15)
    }
}
