//
//  Untitled.swift
//  ExtracurricularActivityApp
//
//  Created by Shyryn Akylbaeva on 08.12.2025.
//

internal import SwiftUI

struct AddClubView: View {
    @EnvironmentObject var clubVM: ClubListViewModel
    
    @Environment(\.dismiss) var dismiss

    @State private var title = ""
    @State private var description = ""
    @State private var place = ""
    @State private var weeklyDay = ""
    @State private var capacity = ""
    
    var body: some View {
        Form {
            Section(header: Text("Үйірме атауы")) {
                TextField("Атауы", text: $title)
            }

            Section(header: Text("Сипаттамасы")) {
                TextField("Сипаттама", text: $description)
            }

            Section(header: Text("Орын / Күні")) {
                TextField("Өтетін жер", text: $place)
                TextField("Күні (мысалы: Сейсенбі)", text: $weeklyDay)
            }

            Section(header: Text("Сыйымдылық")) {
                TextField("Адам саны", text: $capacity)
                    .keyboardType(.numberPad)
            }

            Button("Сақтау") {
                let club = Club(
                    title: title,
                    description: description,
                    place: place,
                    weeklyDay: weeklyDay,
                    startTime: Date(),
                    capacity: Int(capacity) ?? 0,
                    imageName: nil
                )
                clubVM.addClub(club)
                dismiss()
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
        .navigationTitle("Үйірме қосу")
        .withBackButton()
    }
}
