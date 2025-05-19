//
//  EmojiPickerView.swift
//  HabitTracker
//
//  Created by Victor Herrero on 19/05/2025.
//

import Foundation
import SwiftUI
import ElegantEmojiPicker


struct EmojiPickerView: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    @Binding var selectedEmoji: Emoji?
    let configuration: ElegantConfiguration
    let localization: ElegantLocalization
    
    func makeUIViewController(context: Context) -> ElegantEmojiPicker {
        let picker = ElegantEmojiPicker(
            delegate: context.coordinator,
            configuration: configuration,
            localization: localization
        )
        return picker
    }
    
    func updateUIViewController(_ uiViewController: ElegantEmojiPicker, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, ElegantEmojiPickerDelegate, UIAdaptivePresentationControllerDelegate {
        var parent: EmojiPickerView
        
        init(_ parent: EmojiPickerView) {
            self.parent = parent
        }
        
        // MARK: - ElegantEmojiPickerDelegate
        func emojiPicker(_ picker: ElegantEmojiPicker, didSelectEmoji emoji: Emoji?) {
            parent.selectedEmoji = emoji
        }
        
        // MARK: - UIAdaptivePresentationControllerDelegate
        func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
            // Handle dismissal by swipe or other non-programmatic means
            if parent.isPresented {
                parent.isPresented = false
            }
        }
        
    }
}

struct EmojiPickerViewModifier: ViewModifier {
    @Binding var isPresented: Bool
    @Binding var selectedEmoji: Emoji?
    var configuration: ElegantConfiguration = ElegantConfiguration()
    var localization: ElegantLocalization = ElegantLocalization()
    
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented) {
                EmojiPickerView(
                    isPresented: $isPresented,
                    selectedEmoji: $selectedEmoji,
                    configuration: configuration,
                    localization: localization
                )
                .ignoresSafeArea(.container, edges: .bottom)
            }
    }
}

extension View {
    func emojiPicker(
        isPresented: Binding<Bool>,
        selectedEmoji: Binding<Emoji?>,
        configuration: ElegantConfiguration = ElegantConfiguration(),
        localization: ElegantLocalization = ElegantLocalization()
    ) -> some View {
        self.modifier(
            EmojiPickerViewModifier(
                isPresented: isPresented,
                selectedEmoji: selectedEmoji,
                configuration: configuration,
                localization: localization
            )
        )
    }
}
