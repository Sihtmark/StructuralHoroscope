//
//  AddMeetingView.swift
//  SmartRelations
//
//  Created by Sergei Poluboiarinov on 22.06.2023.
//

import SwiftUI

struct AddMeetingView: View {
    
    @EnvironmentObject private var vm: ViewModel
    @Environment(\.dismiss) private var dismiss
    @State var contact: ContactStruct
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
                        .frame(minHeight: 30)
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
                        vm.addMeeting(contact: contact, date: date, feeling: feeling, describe: describe)
                        contact.contact!.lastContact = contact.contact!.allEvents.map{$0.date}.max()!
                        if let i = vm.contacts.firstIndex(where: {$0.id == contact.id}) {
                            vm.contacts[i].contact!.lastContact = contact.contact!.allEvents.map{$0.date}.max()!
                        }
                        dismiss()
                    } label: {
                        Text("Сохранить")
                            .bold()
                            .padding(10)
                            .padding(.horizontal)
                    }
                    .buttonStyle(.borderedProminent)
                    Spacer()
                }
                Spacer()
            }
            .padding(.top, 20)
            .frame(maxWidth: 550)
            .padding()
            .onTapGesture(count: 2) {
                if describeInFocus {
                    describeInFocus = false
                }
            }
        }
    }
}

struct AddMeetingView_Previews: PreviewProvider {
    static var previews: some View {
        AddMeetingView(contact: sampleContact)
            .environmentObject(ViewModel())
            .preferredColorScheme(.light)
        AddMeetingView(contact: sampleContact)
            .environmentObject(ViewModel())
            .preferredColorScheme(.dark)
    }
}
