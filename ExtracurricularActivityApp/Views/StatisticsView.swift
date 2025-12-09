//
//  StatisticsView.swift
//  ExtracurricularActivityApp
//
//  Created by Shyryn Akylbaeva on 10.12.2025.
//

internal import SwiftUI

struct StatisticsView: View {
    @EnvironmentObject var clubVM: ClubListViewModel
    @EnvironmentObject var enrollmentVM: EnrollmentViewModel
    
    var totalClubs: Int {
        clubVM.clubs.count
    }
    
    var totalEnrollments: Int {
        enrollmentVM.enrollments.count
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // Жалпы статистика
                    GroupBox("Жалпы статистика") {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Үйірмелер саны: **\(totalClubs)**")
                            Text("Жалпы тіркелген оқушылар: **\(totalEnrollments)**")
                        }
                        .padding(.vertical, 4)
                    }
                    
                    Divider()
                    
                    // Әр үйірменің статистикасы
                    GroupBox("Үйірмелер бойынша") {
                        ForEach(clubVM.clubs) { club in
                            let enrolled = enrollmentVM.countForClub(club.id)
                            let percent = club.capacity == 0
                                ? 0
                                : Int((Double(enrolled) / Double(club.capacity)) * 100)
                            
                            VStack(alignment: .leading, spacing: 6) {
                                Text(club.title)
                                    .font(.headline)
                                
                                Text("Қатысушылар: \(enrolled)/\(club.capacity)")
                                    .font(.subheadline)
                                
                                ProgressView(value: Double(enrolled), total: Double(club.capacity))
                                    .accentColor(percent >= 70 ? .green : .blue)
                                
                                Text("Толу деңгейі: \(percent)%")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.vertical, 6)
                            
                            Divider()
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Статистика")
        }
    }
}

#Preview {
    StatisticsView()
        .environmentObject(ClubListViewModel())
        .environmentObject(EnrollmentViewModel())
}
