//
//  EmptyHabitsView.swift
//  HabitTracker
//
//  Created by Victor Herrero on 18/05/2025.
//

import SwiftUI


struct EmptyHabitsView: View {
    var onAddHabit: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            Text("🎯")
                .font(.system(size: 60))

            Text("No habits yet")
                .font(.title2)
                .fontWeight(.semibold)

            Text("Start by creating your first habit and begin your journey.")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button(action: onAddHabit) {
                Label("Add Your First Habit", systemImage: "plus.circle.fill")
                    .font(.headline)
                    .padding()
                    .cornerRadius(12)
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    EmptyHabitsView(onAddHabit: { })
}
