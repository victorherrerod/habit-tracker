//
//  HabitDetailView.swift
//  HabitTracker
//
//  Created by Victor Herrero on 19/05/2025.
//

import SwiftUI

struct HabitDetailView: View {
    @StateObject var viewModel: HabitDetailViewModel
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
                    
                    //TODO Calendar View, delete button and Edit behavior
                    
                    
                    Spacer()
                }
                .padding()
                .toolbar {
                    EditButton()
                }
            }
        }
    }
}

#Preview {
    var viewModel = HabitDetailViewModel(habit: .mockList[0])
    HabitDetailView(viewModel: viewModel)
}
