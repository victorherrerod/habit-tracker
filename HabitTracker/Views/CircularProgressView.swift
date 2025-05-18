//
//  CircularProgressView.swift
//  HabitTracker
//
//  Created by Victor Herrero on 18/05/2025.
//

import SwiftUI

struct CircularProgressView: View {
    let progress: Double
    let color: Color
    let lineWidth: CGFloat = 20

    var body: some View {
        ZStack {
            Circle()
                .stroke(color.opacity(0.5), lineWidth: lineWidth)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(color, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)
            if progress >= 1 {
                Image(systemName: "checkmark")
                    .font(.title)
                    .foregroundStyle(color)
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.8), value: progress)
            }
        }
    }
}

#Preview {
    CircularProgressView(progress: 1, color: .blue)
        .frame(width: 200, height: 200)
}
