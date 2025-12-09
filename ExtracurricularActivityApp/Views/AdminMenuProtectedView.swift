//
//  AdminMenuProtectedView.swift
//  ExtracurricularActivityApp
//
//  Created by Shyryn Akylbaeva on 08.12.2025.
//

internal import SwiftUI

struct AdminMenuProtectedView: View {
    @EnvironmentObject var adminAuth: AdminAuthViewModel
    @EnvironmentObject var clubVM: ClubListViewModel

    var body: some View {
        Group {
            if adminAuth.isAdminLoggedIn {
                AdminMenuView() // бұрынғы AdminMenuView; мұнда AdminMenuView ол Admin операцияларын көрсетеді
            } else {
                AdminLoginView()
            }
        }
    }
}
