internal import SwiftUI

enum UserRole: Hashable {
    case parent
    case admin
}

struct RootView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @EnvironmentObject var adminAuth: AdminAuthViewModel

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
                                    if logged {
                                        path.removeAll() // ата-ана үшін басты экран
                                    }
                                }
                        }

                    case .admin:
                        if adminAuth.isAdminLoggedIn {
                            AdminMenuProtectedView()
                        } else {
                            AdminLoginView()
                                .onChange(of: adminAuth.isAdminLoggedIn) { logged in
                                    if logged {
                                        path.removeAll() // админ үшін басты экран
                                    }
                                }
                        }
                    }
                }
        }
    }
}

// ------------------------------------------------
//  🟦 RoleSelectionView осында болуы міндетті!
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
