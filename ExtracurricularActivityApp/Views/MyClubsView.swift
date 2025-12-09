//
//  MyClubsView.swift
//  ExtracurricularActivityApp
//
//  Created by Shyryn Akylbaeva on 08.12.2025.
//

internal import SwiftUI

struct MyClubsView: View {
    @EnvironmentObject var enrollmentVM: EnrollmentViewModel
    @EnvironmentObject var clubVM: ClubListViewModel
    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        NavigationView {
            VStack {
                if let email = authVM.currentUserEmail,
                   !email.isEmpty {

                    let myEnrolls = enrollmentVM.enrollmentsFor(userId: email)

                    if myEnrolls.isEmpty {
                        VStack(spacing: 12) {
                            Text("Сіз әлі ешбір үйірмеге тіркелмедіңіз")
                                .foregroundColor(.secondary)

                            NavigationLink("Үйірмелер тізіміне өту") {
                                ClubListView()
                            }
                            .buttonStyle(DSSecondaryButton())
                        }
                        .padding()

                    } else {
                        List {
                            ForEach(myEnrolls) { enrollment in
                                if let club = clubVM.clubs.first(where: { $0.id == enrollment.clubId }) {
                                    MyClubRow(club: club, enrollment: enrollment)
                                }
                            }
                            .onDelete { offsets in
                                delete(offsets, email: email)
                            }
                        }
                    }

                } else {
                    Text("Алдымен жүйеге кіріңіз")
                        .foregroundColor(.secondary)
                }

                Spacer()
            }
            .navigationTitle("Менің үйірмелерім")
        }
    }

    private func delete(_ offsets: IndexSet, email: String) {
        let myEnrolls = enrollmentVM.enrollmentsFor(userId: email)
        offsets.forEach { index in
            let e = myEnrolls[index]
            enrollmentVM.unenroll(userId: email, clubId: e.clubId)
        }
    }
}

struct MyClubRow: View {
    let club: Club
    let enrollment: Enrollment

    var body: some View {
        HStack {
            Image(systemName: "book.fill")
                .foregroundColor(.blue)
                .font(.system(size: 24))

            VStack(alignment: .leading) {
                Text(club.title).font(.headline)
                Text("\(club.place) • \(club.weeklyDay)")
                    .font(.subheadline).foregroundColor(.secondary)

                Text("Тіркелген: \(enrollment.registeredAt.formatted(date: .numeric, time: .shortened))")
                    .font(.caption).foregroundColor(.gray)
            }

            Spacer()
        }
        .padding(.vertical, 6)
    }
}
