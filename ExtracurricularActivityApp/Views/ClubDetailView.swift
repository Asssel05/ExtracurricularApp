//
//  ClubDetailView.swift
//  ExtracurricularActivityApp
//
//  Created by Shyryn Akylbaeva on 08.12.2025.
//

internal import SwiftUI

struct ClubDetailView: View {
    let club: Club

    @EnvironmentObject var enrollmentVM: EnrollmentViewModel
    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        VStack(spacing: 16) {
            Text(club.title)
                .font(.largeTitle.bold())

            Text(club.description)
                .padding()

            HStack {
                Text("Өтетін орын:")
                Spacer()
                Text(club.place)
            }

            HStack {
                Text("Күні:")
                Spacer()
                Text(club.weeklyDay)
            }

            HStack {
                Text("Сыйымдылығы:")
                Spacer()
                Text("\(club.capacity) адам")
            }

            HStack {
                Text("Қатысушылар:")
                Spacer()
                Text("\(enrollmentVM.count(for: club.id))")
            }

            let userId = authVM.currentUserEmail ?? ""

            if enrollmentVM.isEnrolled(userId: userId, clubId: club.id) {
                Button("Жазылымнан бас тарту") {
                    enrollmentVM.unenroll(userId: userId, clubId: club.id)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)

            } else {
                Button("Жазылу") {
                    if enrollmentVM.count(for: club.id) < club.capacity {
                        enrollmentVM.enroll(userId: userId, clubId: club.id)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }

            Spacer()
        }
        .padding()
        .navigationTitle(club.title)
        
    }
}
