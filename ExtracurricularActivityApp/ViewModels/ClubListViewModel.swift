//
//  ClubListViewModel.swift
//  ExtracurricularActivityApp
//
//  Created by Shyryn Akylbaeva on 08.12.2025.
//

import Foundation
import Combine
internal import SwiftUI

final class ClubListViewModel: ObservableObject {

    @Published var clubs: [Club] = [] {
        didSet {
            saveToStorage()
        }
    }

    private let storageKey = "clubs_storage"

    init() {
        loadFromStorage()
        if clubs.isEmpty { loadSample() }
    }

    func loadSample() {
        clubs = [
            Club(title: "Робототехника", description: "Робот құрастыру және бағдарламалау", place: "101 кабинет", weeklyDay: "Дүйсенбі", startTime: Date(), capacity: 12, imageName: nil),
            Club(title: "Сурет салу", description: "Қылқалам, акварель, композиция", place: "Студия", weeklyDay: "Сәрсенбі", startTime: Date(), capacity: 18, imageName: nil)
        ]
    }

    // MARK: - ADD CLUB
    func addClub(_ club: Club) {
        clubs.append(club)
    }

    // MARK: - DELETE CLUB
    func deleteClub(at offsets: IndexSet) {
        clubs.remove(atOffsets: offsets)
    }

    // MARK: - EDIT CLUB
    func updateClub(_ club: Club) {
        if let index = clubs.firstIndex(where: { $0.id == club.id }) {
            clubs[index] = club
        }
    }

    // MARK: - STORAGE (Database)
    private func saveToStorage() {
        if let encoded = try? JSONEncoder().encode(clubs) {
            UserDefaults.standard.set(encoded, forKey: storageKey)
        }
    }

    private func loadFromStorage() {
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let decoded = try? JSONDecoder().decode([Club].self, from: data) {
            self.clubs = decoded
        }
    }
}
