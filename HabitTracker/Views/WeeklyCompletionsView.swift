//
//  WeeklyCompletionsView.swift
//  HabitTracker
//
//  Created by Victor Herrero on 21/05/2025.
//

import SwiftUI

struct WeeklyCompletionsView: View {
    let completions: [Date]
    let onTap: () -> Void
    var completionSet: Set<Date> {
        Set(completions.map { $0.startOfDay() })
    }
    
    var weekDates: [Date] {
        let calendar = Calendar.current
        return (0..<7).map {
            calendar.date(byAdding: .day, value: -$0, to: Date())!.startOfDay()
        }.reversed()
    }
    var body: some View {
        HStack {
            ForEach(weekDates, id: \.self) { date in
                VStack {
                    Circle()
                        .fill(completionSet.contains(date) ? Color.green : Color.gray.opacity(0.2))
                        .frame(width: 20, height: 20)
                    Text(date.formatted(.dateTime.weekday(.narrow)))
                        .font(.caption2)
                }
            }
        }
    }
}

#Preview {
    WeeklyCompletionsView(completions: Date.mockList, onTap: { })
}
