//
//  SampleData.swift
//  HabitTracker
//
//  Created by Victor Herrero on 15/05/2025.
//

import Foundation
import SwiftData

@MainActor
class SampleData {
    static let shared = SampleData()
    
    let modelContainer: ModelContainer
    
    var context: ModelContext {
        modelContainer.mainContext
    }
    
    private init() {
        let schema = Schema([
            Habit.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        
        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            
            insertSampleData()
            try context.save()
        } catch {
            fatalError("Unable to initialize ModelContainer: \(error)")
        }
    }
    
    private func insertSampleData() {
        for habit in Habit.mockList {
            context.insert(habit)
        }
    }
}
