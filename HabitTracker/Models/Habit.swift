//
//  Habit.swift
//  HabitTracker
//
//  Created by Victor Herrero on 14/05/2025.
//

import Foundation
import SwiftData
import SwiftUICore

@Model
final class Habit {
    var id: UUID
    var name: String
    var emoji: String
    var color: String
    var createdAt: Date
    var completions: [Date]
    var isActive: Bool = true
    var frequency: HabitFrequency
    
    init(
        id: UUID = .init(),
        name: String,
        emoji: String = "✅",
        color: String = "#0000FF",
        createdAt: Date = Date(),
        completions: [Date] = [],
        frequency: HabitFrequency = .daily
    ) {
        self.id = id
        self.name = name
        self.emoji = emoji
        self.color = color
        self.createdAt = createdAt
        self.completions = completions
        self.frequency = frequency
    }
    
    // MARK: - Helper methods
    
    func isCompleted(on date: Date) -> Bool {
        completions.contains { Calendar.current.isDate($0, inSameDayAs: date) }
    }
    
    var isCompletedToday: Bool {
        isCompleted(on: Date())
    }
    
    func markCompleted(on date: Date) {
        guard !isCompleted(on: date) else { return }
        completions.append(date)
    }
    
    func markCompletedToday() {
        markCompleted(on: Date())
    }
    
    func unmarkCompleted(on date: Date) {
        completions.removeAll { Calendar.current.isDate($0, inSameDayAs: date) }
    }
    func unmarkCompletedToday() {
        unmarkCompleted(on: Date())
    }
    
    var currentStreak: Int {
        var streak = 0
        var date = Date()
        
        while completions.contains(where: { Calendar.current.isDate($0, inSameDayAs: date) }) {
            streak += 1
            date = Calendar.current.date(byAdding: .day, value: -1, to: date)!
        }
        return streak
    }
}

extension Habit {
    var uiColor: Color {
        Color(hex: color) ?? Color(color)
    }
    
#if DEBUG    
    static var mockList: [Habit] = [
        Habit(name: "Read a Book", emoji: "📚", color: "#FF9500", completions: Date.mockList),
        Habit(name: "Drink Water", emoji: "💧", color: "#34C759"),
        Habit(name: "Meditate", emoji: "🧘‍♂️", color: "#AF52DE"),
        Habit(name: "Workout", emoji: "🏋️", color: "#FF3B30")
    ]
#endif
}

enum HabitFrequency: String, Codable, CaseIterable {
    case daily
    case weekly
    case monthly
}
