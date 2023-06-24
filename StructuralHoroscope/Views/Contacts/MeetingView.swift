import SwiftUI

struct MeetingView: View {
    
    @EnvironmentObject private var vm: ViewModel
    @Environment(\.dismiss) private var dismiss
    let meeting: Meeting
    @Binding var contact: ContactStruct
    @State private var date = Date()
    @State private var feeling = Feelings.notTooBad
    @State private var describe = ""
    @FocusState private var describeInFocus: Bool
    
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
                HStack {
                    Spacer()
                    DatePicker(selection: $date, in: dateRange, displayedComponents: .date) {}
                        .foregroundColor(.theme.accent)
                        .datePickerStyle(.wheel)
                        .frame(width: 320, height: 180)
                        .padding(.trailing, 7.5)
                        .overlay(alignment: .bottom) {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.gray.opacity(0.2))
                                .allowsHitTesting(false)
                        }
                    Spacer()
                }
                Picker("", selection: $feeling) {
                    ForEach(Feelings.allCases, id: \.self) { feeling in
                        Text(feeling.rawValue).tag(feeling)
                    }
                }
                .pickerStyle(.segmented)
                VStack(alignment: .leading, spacing: 10) {
                    Text("Заметки или описание встречи:")
                        .foregroundColor(.theme.standard)
                    if describeInFocus {
                        Text("Дважды коснитесь экрана в свободном месте чтобы убрать клавиатуру")
                            .font(.caption)
                            .bold()
                            .foregroundColor(.theme.secondaryText)
                    }
                    TextEditor(text: $describe)
                        .focused($describeInFocus)
                        .frame(minHeight: 100)
                        .foregroundColor(.theme.secondaryText)
                        .padding(10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.gray.opacity(0.2))
                                .allowsHitTesting(false)
                        }
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
                    .disabled(contact.contact!.allEvents.count < 2)
                    Spacer()
                }
                Spacer()
            }
            .padding()
            .padding(.vertical, 20)
        }
        .frame(maxWidth: 550)
        .onAppear {
            date = meeting.date
            feeling = meeting.feeling
            describe = meeting.describe
        }
        .onTapGesture(count: 2) {
            if describeInFocus {
                describeInFocus = false
            }
        }
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(meeting: sampleContact.contact!.allEvents.first!, contact: .constant(sampleContact))
            .environmentObject(ViewModel())
            .preferredColorScheme(.light)
        MeetingView(meeting: sampleContact.contact!.allEvents.first!, contact: .constant(sampleContact))
            .environmentObject(ViewModel())
            .preferredColorScheme(.dark)
    }
}
