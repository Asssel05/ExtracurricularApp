//
//  Club.swift
//  ExtracurricularActivityApp
//
//  Created by Shyryn Akylbaeva on 08.12.2025.
//

import Foundation

struct Club: Codable, Identifiable, Equatable {
    var id = UUID().uuidString
    var title: String
    var description: String
    var place: String
    var weeklyDay: String
    var startTime: Date
    var capacity: Int
    var imageName: String?
}
