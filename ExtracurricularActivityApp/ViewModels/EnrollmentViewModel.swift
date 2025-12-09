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
    private let storageKey = "app.enrollments.v1"

    init() {
        loadFromStorage()
    }

    // enroll
    func enroll(userId: String, clubId: String) {
        // алдын ала код: capacity тексеру т.б. қосуға болады
        let e = Enrollment(id: UUID().uuidString, userId: userId, clubId: clubId, registeredAt: Date())
        enrollments.append(e)
        saveToStorage()
    }

    func unenroll(userId: String, clubId: String) {
        enrollments.removeAll { $0.userId == userId && $0.clubId == clubId }
        saveToStorage()
    }

    func isEnrolled(userId: String, clubId: String) -> Bool {
        enrollments.contains { $0.userId == userId && $0.clubId == clubId }
    }

    func countForClub(_ clubId: String) -> Int {
        enrollments.filter { $0.clubId == clubId }.count
    }

    // Storage
    func saveToStorage() {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let data = try encoder.encode(enrollments)
            UserDefaults.standard.set(data, forKey: storageKey)
        } catch {
            print("Enrollment save error:", error)
        }
    }

    func loadFromStorage() {
        guard let data = UserDefaults.standard.data(forKey: storageKey) else { return }
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let arr = try decoder.decode([Enrollment].self, from: data)
            self.enrollments = arr
        } catch {
            print("Enrollment load error:", error)
        }
    }
    func enrollmentsFor(userId: String) -> [Enrollment] {
        enrollments.filter { $0.userId == userId }
    }

    
}
