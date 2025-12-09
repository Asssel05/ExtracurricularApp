internal import SwiftUI

struct AdminMenuView: View {
    @EnvironmentObject var clubVM: ClubListViewModel
    @EnvironmentObject var adminAuth: AdminAuthViewModel

    var body: some View {
        VStack {
            List {
                ForEach(clubVM.clubs) { club in
                    NavigationLink(destination: EditClubView(club: club)) {
                        VStack(alignment: .leading) {
                            Text(club.title)
                                .font(.headline)
                            Text(club.place)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)

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

            // 🔥 АДМИН ШЫҒУ БАТЫРМАСЫ
            Button("Шығу (Админ)") {
                adminAuth.logout()   // ← ДҰРЫСЫ ОСЫ!
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
