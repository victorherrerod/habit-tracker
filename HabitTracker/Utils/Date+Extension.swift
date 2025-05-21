//
//  Date+Extension.swift
//  HabitTracker
//
//  Created by Victor Herrero on 21/05/2025.
//

import Foundation

extension Date {
    static func daysAgo(_ days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: -days, to: Date())!
    }
    
    func startOfDay() -> Date {
        Calendar.current.startOfDay(for: self)
    }
    
#if DEBUG
    static var mockList: [Date] = [
        .daysAgo(0),
        .daysAgo(1),
        .daysAgo(3),
        .daysAgo(4),
        .daysAgo(6),
        .daysAgo(7),
        .daysAgo(10),
        .daysAgo(12),
        .daysAgo(15)
    ]
#endif
}
