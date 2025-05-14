//
//  Color+Extension.swift
//  HabitTracker
//
//  Created by Victor Herrero on 14/05/2025.
//

import Foundation
import SwiftUICore

extension Color {
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        let length = hexSanitized.count
        
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
        
        let r, g, b: Double
        if length == 6 {
            r = Double((rgb & 0xFF0000) >> 16) / 255
            g = Double((rgb & 0x00FF00) >> 8) / 255
            b = Double(rgb & 0x0000FF) / 255
        } else {
            return nil
        }
        
        self.init(red: r, green: g, blue: b)
    }
}
