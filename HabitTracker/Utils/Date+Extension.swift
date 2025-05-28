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
    
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
    
    var startOfMonth: Date {
        Calendar.current.dateInterval(of: .month, for: self)!.start
    }

    var endOfMonth: Date {
        let nextMonthFirstDay = Calendar.current.dateInterval(of: .month, for: self)!.end
        return Calendar.current.date(byAdding: .day, value: -1, to: nextMonthFirstDay)!
    }

    var nextDay: Date {
        Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
    
    var previousDay: Date {
        Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }

    func isIn(month date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .month)
    }

    static var weekdaysSymbols: [String] {
        let weekdaySymbols = Calendar.current.shortWeekdaySymbols
        let firstWeekday = Calendar.current.firstWeekday - 1
        return Array(weekdaySymbols[firstWeekday...] + weekdaySymbols[..<firstWeekday])
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
