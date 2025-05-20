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
    @State var viewModel: HabitDetailViewModel
    @State private var isDeleting = false

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
                        .padding()
                    
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
                    
                    Spacer()
                }
                .padding(32)
                .toolbar {
                    EditButton()
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
