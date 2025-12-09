//
//  Untitled.swift
//  ExtracurricularActivityApp
//
//  Created by Shyryn Akylbaeva on 08.12.2025.
//

internal import SwiftUI

struct AddClubView: View {
    @EnvironmentObject var clubVM: ClubListViewModel
    @Environment(\.presentationMode) var presentationMode

    @State private var title: String = ""
    @State private var description: String = ""
    @State private var place: String = ""
    @State private var weeklyDay: String = "Дүйсенбі"
    @State private var startTime: Date = Date()
    @State private var capacity: String = "10"
    @State private var instructor: String = ""

    var body: some View {
        Form {
            Section(header: Text("Негізгі")) {
                TextField("Атауы", text: $title)
                TextField("Сипаттамасы", text: $description)
                TextField("Орын (кабинет)", text: $place)
                TextField("Жетекші", text: $instructor)
            }

            Section(header: Text("Күн және уақыт")) {
                Picker("Күні", selection: $weeklyDay) {
                    Text("Дүйсенбі").tag("Дүйсенбі")
                    Text("Сейсенбі").tag("Сейсенбі")
                    Text("Сәрсенбі").tag("Сәрсенбі")
                    Text("Бейсенбі").tag("Бейсенбі")
                    Text("Жұма").tag("Жұма")
                    Text("Сенбі").tag("Сенбі")
                    Text("Жексенбі").tag("Жексенбі")
                }
                DatePicker("Басталатын уақыт", selection: $startTime, displayedComponents: [.hourAndMinute])
                    .datePickerStyle(WheelDatePickerStyle())
            }

            Section(header: Text("Қабілет")) {
                TextField("Капасити", text: $capacity)
                    .keyboardType(.numberPad)
            }

            Button("Үйірме қосу") {
                let cap = Int(capacity) ?? 10
                // батырма ішіндегі club жасауда:
                let club = Club(
                    title: title,
                    description: description,
                    place: place,
                    weeklyDay: weeklyDay,
                    startTime: startTime,    // Date
                    capacity: cap,
                    imageName: nil,
                    instructor: instructor
                )
                clubVM.addClub(club)
                presentationMode.wrappedValue.dismiss()
            }
            .disabled(title.isEmpty)
        }
        .navigationTitle("Жаңа үйірме қосу")
    }
}
