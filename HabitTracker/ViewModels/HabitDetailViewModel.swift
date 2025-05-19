//
//  HabitDetailViewModel.swift
//  HabitTracker
//
//  Created by Victor Herrero on 20/05/2025.
//


import Foundation
import SwiftUI

class HabitDetailViewModel: ObservableObject {
    @Published var habit: Habit
    
    init(habit: Habit) {
        self.habit = habit
    }
    
    // MARK: - Derived Values
    
    var completionsThisWeek: Int {
        completions(inLast: 7)
    }
    
    var currentStreak: Int {
        habit.currentStreak
    }
    
    var longestStreak: Int {
        calculateLongestStreak()
    }
    
    // MARK: - Helpers
    
    func completions(inLast days: Int) -> Int {
        let fromDate = Calendar.current.date(byAdding: .day, value: -days + 1, to: Date())!
        return habit.completions.filter { $0 >= fromDate }.count
    }
    
    // O(n) instead of O(nlogn) by using a set
    func calculateLongestStreak() -> Int {
        let calendar = Calendar.current
        let normalizedDates = Set(habit.completions.map { calendar.startOfDay(for: $0) })
        
        var longest = 0
        
        for date in normalizedDates {
            // we only go into the inner loop for days that are the start of a new streak
            let previousDay = calendar.date(byAdding: .day, value: -1, to: date)!
            if !normalizedDates.contains(previousDay) {
                var currentStreak = 1
                var nextDay = calendar.date(byAdding: .day, value: 1, to: date)!
                
                while normalizedDates.contains(nextDay) {
                    currentStreak += 1
                    nextDay = calendar.date(byAdding: .day, value: 1, to: nextDay)!
                }
                
                longest = max(longest, currentStreak)
            }
        }
        return longest
    }
}
