internal import SwiftUI
import UserNotifications

func requestNotificationPermission() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
        if granted {
            print("Notifications allowed")
        } else {
            print("Notifications denied")
        }
    }
}

enum UserRole: Hashable {
    case parent
    case admin
}

struct RootView: View {

    // ✔️ ГЛОБАЛЬ МОДЕЛДЕР
    @StateObject var clubVM = ClubListViewModel()
    @StateObject var enrollmentVM = EnrollmentViewModel()
    @StateObject var authVM = AuthViewModel()
    @StateObject var adminAuth = AdminAuthViewModel()

    @State private var path: [UserRole] = []

    var body: some View {
        NavigationStack(path: $path) {
            
            RoleSelectionView(path: $path)
                .navigationDestination(for: UserRole.self) { role in

                    switch role {

                    case .parent:
                        if authVM.isLoggedIn {
                            MainTabView()
                        } else {
                            LoginView()
                                .onChange(of: authVM.isLoggedIn) { logged in
                                    if logged { path.removeAll() }
                                }
                        }

                    case .admin:
                        if adminAuth.isAdminLoggedIn {
                            AdminMenuProtectedView()
                        } else {
                            AdminLoginView()
                                .onChange(of: adminAuth.isAdminLoggedIn) { logged in
                                    if logged { path.removeAll() }
                                }
                        }
                    }
                }
        }
        // ✔️ Барлық view-ларға модельдерді тарату
        .environmentObject(clubVM)
        .environmentObject(enrollmentVM)
        .environmentObject(authVM)
        .environmentObject(adminAuth)
        .onAppear { requestNotificationPermission() }
    }
}

// ------------------------------------------------
//  🟦 RoleSelectionView
// ------------------------------------------------

struct RoleSelectionView: View {
    @Binding var path: [UserRole]

    var body: some View {
        VStack(spacing: 30) {
            Text("Жүйеге кіру түрін таңдаңыз")
                .font(.title2.bold())
                .padding(.top, 40)

            Button("Ата-ана ретінде кіру") {
                path.append(.parent)
            }
            .buttonStyle(DSPrimaryButton())

            Button("Ұстаз / Админ ретінде кіру") {
                path.append(.admin)
            }
            .buttonStyle(DSSecondaryButton())

            Spacer()
        }
        .padding()
        .navigationTitle("Кіру түрі")
        .navigationBarTitleDisplayMode(.inline)
    }
}
