//
//  HabitDetailView.swift
//  HabitTracker
//
//  Created by Victor Herrero on 19/05/2025.
//

import SwiftUI

struct HabitDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    var viewModel: HabitDetailViewModel
    @State private var isDeleting = false
    @State private var isShowingCalendar = false

    var body: some View {
        NavigationStack{
            ScrollView {
                VStack {
                    VStack {
                        Text(viewModel.habit.emoji)
                            .font(.system(size: 72))
                        Text(viewModel.habit.name)
                            .font(.largeTitle)
                            .bold()
                        
                        Text(viewModel.habit.frequency.rawValue.capitalized)
                            .font(.title)
                            .foregroundStyle(viewModel.habit.uiColor.isLight() ? .black : .white)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 24)
                            .background(viewModel.habit.uiColor)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .padding(.bottom)
                    }
                    Divider()
                        .overlay(.secondary)
                    
                    VStack(alignment: .leading) {
                        Text("Completion History")
                            .font(.title)
                            .bold()
                            .padding(.vertical)
                        Text("""
Completed \(viewModel.completionsThisWeek) out of last 7 days
Current streak: \(viewModel.currentStreak) days
Longest streak: \(viewModel.longestStreak) days
""")
                        .font(.title2)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    //TODO Calendar View and Edit behavior
                    WeeklyCompletionsView(completions: viewModel.habit.completions, onTap: {
                        isShowingCalendar.toggle()
                    })
                        .padding(.vertical)
                    
                    Button(role: .destructive) {
                        isDeleting = true
                    } label: {
                        HStack {
                            Spacer()
                            Text("Delete Habit")
                                .font(.title2)
                            Spacer()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.vertical)
                    
                }
                .padding(32)
                .toolbar {
                    EditButton()
                }
                .sheet(isPresented: $isShowingCalendar) {
                    StreakCalendarView(completions: Set(viewModel.habit.completions.map { $0.startOfDay }), selectedDate: Date().startOfDay, color: viewModel.habit.uiColor)
                        .presentationDetents([.medium])
                }
                .alert("Delete Habit?", isPresented: $isDeleting) {
                    Button("Delete", role: .destructive) {
                        deleteHabit(viewModel.habit)
                        dismiss()
                    }
                }
            }
        }
    }

    func deleteHabit(_ habit: Habit) {
        modelContext.delete(habit)
        dismiss()
    }
}

#Preview {
    let viewModel = HabitDetailViewModel(habit: .mockList[0])
    HabitDetailView(viewModel: viewModel)
}
