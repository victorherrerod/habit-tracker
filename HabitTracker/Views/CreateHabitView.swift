//
//  CreateHabitView.swift
//  HabitTracker
//
//  Created by Victor Herrero on 19/05/2025.
//

import SwiftUI
import ElegantEmojiPicker

struct CreateHabitView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State var name: String = ""
    @State var emoji: Emoji? = nil
    @State var color: Color = .blue
    @State var frequency: HabitFrequency = .daily

    @State var isEmojiPickerPresented: Bool = false
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("e.g. Morning workout", text: $name)
                } header: {
                    Text("Habit Name")
                }
                Section {
                    HStack {
                        Text("Pick an emoji")
                        Spacer()
                        Button {
                            isEmojiPickerPresented.toggle()
                        } label: {
                            Text(emoji?.emoji ?? "🎯")
                                .font(.title)
                        }
                        .buttonStyle(.bordered)
                    }
                } header: {
                    Text("Emoji")
                }
                Section {
                    ColorPicker("Pick a color", selection: $color)
                } header: {
                    Text("Color")
                }
                
                Section {
                    Picker("Frequency", selection: $frequency) {
                        ForEach(HabitFrequency.allCases, id: \.self) { frequency in
                            Text(frequency.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Frequency")
                }
                Section {
                    HabitRowView(habit: Habit(name: name, emoji: emoji?.emoji ?? "🎯", color: color.toHexString() ?? "", frequency: frequency))
                        .frame(minHeight: 48)
                } header: {
                    Text("Preview")
                }
                Section {
                    Button(action: createHabit) {
                        Label("Create Habit", systemImage: "checkmark.circle.fill")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
            .navigationTitle("New Habit")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .emojiPicker(isPresented: $isEmojiPickerPresented, selectedEmoji: $emoji)
        }
    }
    
    func createHabit() {
        guard let colorHex = color.toHexString() else {
            return
        }
        let newHabit = Habit(name: name, emoji: emoji?.emoji ?? "🎯", color: colorHex, frequency: frequency)
        modelContext.insert(newHabit)
        dismiss()
    }
}

#Preview {
    CreateHabitView()
}
