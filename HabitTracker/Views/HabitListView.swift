//
//  HabitListView.swift
//  HabitTracker
//
//  Created by Victor Herrero on 14/05/2025.
//

import SwiftUI
import SwiftData

struct HabitListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var habits: [Habit]
    
    var completedHabits: [Habit] {
        habits.filter { $0.isCompletedToday }
    }
    
    var completionRate: Double {
        guard !habits.isEmpty else { return 0 }
        return Double(completedHabits.count) / Double(habits.count)
    }
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("Today")
                    .font(.largeTitle.bold())
                    .padding(.top)
                
                Text(Date.now.formatted(date: .long, time: .omitted))
                    .foregroundStyle(.secondary)
                
                if !habits.isEmpty {
                    ProgressView(value: completionRate)
                        .tint(.green)
                        .padding(.vertical)
                    Text("\(completedHabits.count)/\(habits.count) habits completed")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
                List {
                    ForEach(habits) { habit in
                        NavigationLink {
                            Text("")
                        } label: {
                            HabitRowView(habit: habit)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem {
                        Button(action: addItem) {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Habit(name: "")
            modelContext.insert(newItem)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(habits[index])
            }
        }
    }
}

#Preview {
    HabitListView()
        .modelContainer(SampleData.shared.modelContainer)
}
