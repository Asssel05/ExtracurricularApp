//
//  EnrollmentViewModel.swift
//  ExtracurricularActivityApp
//
//  Created by Shyryn Akylbaeva on 08.12.2025.
//

import Foundation
import Combine

final class EnrollmentViewModel: ObservableObject {

    @Published var enrollments: [Enrollment] = []

    func enroll(userId: String, clubId: String) {
        let item = Enrollment(userId: userId, clubId: clubId, registeredAt: Date())
        enrollments.append(item)
    }

    func unenroll(userId: String, clubId: String) {
        enrollments.removeAll { $0.userId == userId && $0.clubId == clubId }
    }

    func isEnrolled(userId: String, clubId: String) -> Bool {
        enrollments.contains { $0.userId == userId && $0.clubId == clubId }
    }

    func count(for clubId: String) -> Int {
        enrollments.filter { $0.clubId == clubId }.count
    }
    
    func enrolledClubs(for userId: String) -> [Enrollment] {
        enrollments.filter { $0.userId == userId }
    }
    // ViewModels/EnrollmentViewModel.swift ішінде
    func enrollmentsFor(userId: String) -> [Enrollment] {
        enrollments.filter { $0.userId == userId }
    }

}




