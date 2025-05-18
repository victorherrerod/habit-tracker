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
        NavigationSplitView(columnVisibility: .constant(.doubleColumn)) {
            if !habits.isEmpty {
                List {
                    Section {
                        HStack {
                            CircularProgressView(progress: completionRate, color: .green)
                                .frame(width: 100, height: 100)
                                .padding()
                                .padding(.trailing, 16)
                            VStack(spacing: 8) {
                                Text(Date.now.formatted(date: .long, time: .omitted))
                                    .font(.headline)
                                
                                Text("\(completedHabits.count)/\(habits.count) habits completed")
                                    .font(.subheadline)
                                    .foregroundStyle(.gray)
                            }
                        }
                    }
                    Section {
                        ForEach(habits) { habit in
                            NavigationLink {
                                Text("")
                            } label: {
                                HabitRowView(habit: habit)
                            }
                        }
                        .onDelete(perform: deleteItems)
                    } header: {
                        SectionHeaderView(text: "Habits")
                    }
                }
                .navigationTitle("Today")
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
                .toolbar(removing: .sidebarToggle)
            } else {
                EmptyHabitsView(onAddHabit: addItem)
            }
        } detail: {
            Text("Details")
        }
        .navigationSplitViewStyle(.balanced)
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
