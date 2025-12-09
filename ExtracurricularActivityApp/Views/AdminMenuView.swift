internal import SwiftUI

struct AdminMenuView: View {
    @EnvironmentObject var clubVM: ClubListViewModel
    @EnvironmentObject var adminAuth: AdminAuthViewModel
    @EnvironmentObject var enrollmentVM: EnrollmentViewModel

    var body: some View {
        VStack {
            List {
                // Үйірмелер тізімі
                ForEach(clubVM.clubs) { club in
                    NavigationLink(destination: EditClubView(club: club)) {

                        VStack(alignment: .leading, spacing: 6) {
                            
                            Text(club.title)
                                .font(.headline)

                            Text("Өтетін жері: \(club.place)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)

                            Text("Жетекшісі: \(club.instructor)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)

                            Text("Басталу уақыты: \(club.startTime.toReadableDayAndTime())")
                                .font(.subheadline)
                                .foregroundColor(.secondary)

                            HStack {
                                Image(systemName: "person.3.fill")
                                    .foregroundColor(.blue)

                                Text("Тіркелгендер: \(enrollmentVM.countForClub(club.id)) оқушы")
                                    .font(.subheadline)
                            }
                            .padding(.top, 4)
                        }
                        .padding(.vertical, 6)
                    }
                }

                // 🔥 Жаңа: Статистика экраны
                NavigationLink("Статистика") {
                    StatisticsView()
                }
                .font(.headline)
            }
            .listStyle(.insetGrouped)

            // Үйірме қосу
            NavigationLink(destination: AddClubView()) {
                Text("Жаңа үйірме қосу")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.horizontal)
            }
            .padding(.bottom, 10)

            // Шығу батырмасы
            Button("Шығу (Админ)") {
                adminAuth.logout()
            }
            .buttonStyle(DSSecondaryButton())
            .foregroundColor(.red)
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
        .navigationTitle("Админ панель")
        .navigationBarTitleDisplayMode(.inline)
    }
}
