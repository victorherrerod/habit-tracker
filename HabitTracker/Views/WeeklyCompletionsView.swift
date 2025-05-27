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
        Button(action: onTap) {
            HStack {
                ForEach(weekDates, id: \.self) { date in
                    VStack {
                        Circle()
                            .fill(completionSet.contains(date) ? Color.green : Color.gray.opacity(0.2))
                            .padding(.horizontal, 8)
                        Text(date.formatted(.dateTime.weekday(.short)))
                    }
                }
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 3)
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    WeeklyCompletionsView(completions: Date.mockList, onTap: { })
}
