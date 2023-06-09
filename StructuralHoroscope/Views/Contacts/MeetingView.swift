import SwiftUI

struct MeetingView: View {
    
    @EnvironmentObject private var vm: ViewModel
    @Environment(\.dismiss) private var dismiss
    let meeting: Meeting
    @Binding var contact: ContactStruct
    @State private var date = Date()
    @State private var feeling = Feelings.notTooBad
    @State private var describe = ""
    
    var dateRange: ClosedRange<Date> {
        var dateComponents = DateComponents()
        dateComponents.year = 1850
        dateComponents.month = 1
        dateComponents.day = 1
        let calendar = Calendar(identifier: .gregorian)
        let min = calendar.date(from: dateComponents)!
        let max = Date()
        return min...max
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.gray.opacity(0.2))
                        .frame(width: 310, height: 180)
                    DatePicker(selection: $date, in: dateRange, displayedComponents: .date) {}
                        .foregroundColor(.theme.accent)
                        .datePickerStyle(.wheel)
                        .padding(.trailing, 40)
                }
                Picker("", selection: $feeling) {
                    ForEach(Feelings.allCases, id: \.self) { feeling in
                        Text(feeling.rawValue).tag(feeling)
                    }
                }
                .pickerStyle(.segmented)
                TextEditor(text: $describe)
                    .frame(height: 200)
                    .foregroundColor(.theme.secondaryText)
                    .padding(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.gray.opacity(0.2))
                            .allowsHitTesting(false)
                    }
                HStack {
                    Spacer()
                    Button {
                        vm.updateMeeting(contact: contact, meeting: meeting, date: date, feeling: feeling, describe: describe)
                        if let index = contact.contact!.allEvents.firstIndex(where: {$0.id == meeting.id}) {
                            contact.contact!.allEvents[index] = contact.contact!.allEvents[index].updateMeeting(date: date, feeling: feeling, describe: describe)
                        }
                        contact.contact!.lastContact = contact.contact!.allEvents.map{$0.date}.max()!
                        dismiss()
                        if let i = vm.contacts.firstIndex(where: {$0.id == contact.id}) {
                            vm.contacts[i].contact!.lastContact = contact.contact!.allEvents.map{$0.date}.max()!
                        }
                    } label: {
                        Text("Сохранить")
                            .bold()
                            .padding(10)
                            .padding(.horizontal)
                    }
                    .buttonStyle(.borderedProminent)
                    Spacer()
                }
                HStack {
                    Spacer()
                    Button(role: .destructive) {
                        vm.deleteMeeting(contact: contact, meeting: meeting)
                        if let index = contact.contact!.allEvents.firstIndex(where: {$0.id == meeting.id}) {
                            contact.contact!.allEvents.remove(at: index)
                        }
                        contact.contact!.lastContact = contact.contact!.allEvents.map{$0.date}.max()!
                        if let i = vm.contacts.firstIndex(where: {$0.id == contact.id}) {
                            vm.contacts[i].contact!.lastContact = contact.contact!.allEvents.map{$0.date}.max()!
                        }
                        dismiss()
                    } label: {
                        Text("Удалить")
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding()
            .onAppear {
                date = meeting.date
                feeling = meeting.feeling
                describe = meeting.describe
            }
        }
    }
}

//struct EventView_Previews: PreviewProvider {
//    static var previews: some View {
//        MeetingView(meeting: sampleContact.contact!.allEvents.first!, contact: sampleContact)
//            .environmentObject(ViewModel())
//            .preferredColorScheme(.light)
//        MeetingView(meeting: sampleContact.contact!.allEvents.first!, contact: sampleContact)
//            .environmentObject(ViewModel())
//            .preferredColorScheme(.dark)
//    }
//}
