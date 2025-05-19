//
//  HabitRowView.swift
//  HabitTracker
//
//  Created by Victor Herrero on 14/05/2025.
//

import SwiftUI
import SwiftData


struct HabitRowView: View {
    @Bindable var habit: Habit

    var body: some View {
        HStack {
            Text(habit.emoji)
                .font(.title2)

            VStack(alignment: .leading) {
                Text(habit.name)
                    .font(.headline)
                Text(streakText)
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()

            Button {
                withAnimation {
                    if habit.isCompletedToday {
                        habit.unmarkCompletedToday()
                    } else {
                        habit.markCompletedToday()
                    }
                }
            } label: {
                Image(systemName: habit.isCompletedToday ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(habit.uiColor)
                    .font(.title2)
            }
            .buttonStyle(.plain)
            .sensoryFeedback(.success, trigger: habit.isCompletedToday)
        }
        .padding(.vertical, 4)
    }

    var streakText: String {
        habit.currentStreak > 0 ? "\(habit.currentStreak)-day streak 🔥" : "Start today!"
    }
}

#Preview {
    @Previewable @State var mockHabit = Habit(name: "Test")
    HabitRowView(habit: mockHabit)
}
