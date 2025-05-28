//
//  StreakCalendarView.swift
//  HabitTracker
//
//  Created by Victor Herrero on 28/05/2025.
//


import SwiftUI

struct StreakCalendarView: View {
    let completions: Set<Date>
    let selectedDate: Date
    let color: Color
    let weekdays = Date.weekdaysSymbols
    let columns = Array(repeating: GridItem(.flexible()), count: 7)

    private var monthGrid: [[Date]] {
        generateCalendarDays(for: selectedDate)
    }

    var body: some View {
        VStack {
            Text(selectedDate.formatted(.dateTime.year().month(.wide)))
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding()
            HStack {
                ForEach(weekdays.indices, id: \.self) { index in
                    Text(weekdays[index])
                        .font(.headline)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                }
            }

            // Grid
            VStack {
                ForEach(monthGrid, id: \.self) { week in
                    ZStack {
                        streakBackground(for: week)
                        HStack {
                            ForEach(week, id: \.self) { day in
                                if !day.isIn(month: selectedDate) {
                                    Text("")
                                        .frame(maxWidth: .infinity, minHeight: 40)
                                } else {
                                    Text(day.formatted(.dateTime.day()))
                                        .fontWeight(.bold)
                                        
                                        .frame(maxWidth: .infinity, minHeight: 40)
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }
    
    @ViewBuilder
    func streakBackground(for week: [Date]) -> some View {
        
        HStack(spacing: 0) {
            ForEach(week, id: \.self) { day in
                if completions.contains(day) {
                    color
                        .frame(maxWidth: .infinity)
                        .clipShape(streakShape(date: day))
                } else {
                    Color.clear
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .frame(height: 36)
    }

    func streakShape(date: Date) -> some Shape {
        switch (completions.contains(date.previousDay),  completions.contains(date.nextDay)) {
        case (true, true):
            AnyShape(Rectangle())
        case (false, true):
            AnyShape(UnevenRoundedRectangle(topLeadingRadius: 12, bottomLeadingRadius: 12))
        case (true, false):
            AnyShape(UnevenRoundedRectangle(bottomTrailingRadius: 12, topTrailingRadius: 12))
        case (false, false):
            AnyShape(RoundedRectangle(cornerRadius: 12))
        }
    }

    func generateCalendarDays(for month: Date) -> [[Date]] {
        let monthStart = month.startOfMonth
        let monthEnd = month.endOfMonth

        var current = Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: monthStart))!
        var weeks: [[Date]] = []

        while current <= monthEnd {
            var week = [Date]()
            for _ in 0..<7 {
                week.append(current)
                current = Calendar.current.date(byAdding: .day, value: 1, to: current)!
            }
            weeks.append(week)
        }

        return weeks
    }
}

#Preview {
    var completions: Set<Date> = [
        Calendar.current.date(byAdding: .day, value: -1, to: Date().startOfDay)!,
        Calendar.current.date(byAdding: .day, value: -2, to: Date().startOfDay)!,
        Calendar.current.date(byAdding: .day, value: -4, to: Date().startOfDay)!,
        Calendar.current.date(byAdding: .day, value: -5, to: Date().startOfDay)!,
        Calendar.current.date(byAdding: .day, value: -6, to: Date().startOfDay)!,
        Calendar.current.date(byAdding: .day, value: 1, to: Date().startOfDay)!,
        Calendar.current.date(byAdding: .day, value: 2, to: Date().startOfDay)!,
        Calendar.current.date(byAdding: .day, value: 3, to: Date().startOfDay)!,
        Calendar.current.date(byAdding: .day, value: -10, to: Date().startOfDay)!,
        Calendar.current.date(byAdding: .day, value: -15, to: Date().startOfDay)!,
    ]

    StreakCalendarView(completions: completions, selectedDate: Date(), color: .red)
}
