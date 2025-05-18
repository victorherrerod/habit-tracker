//
//  SectionHeaderView.swift
//  HabitTracker
//
//  Created by Victor Herrero on 18/05/2025.
//

import SwiftUI

struct SectionHeaderView: View {
    var text: LocalizedStringKey
    var body: some View {
        Text(text)
            .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
            .headerProminence(.increased)
    }
}

#Preview {
    SectionHeaderView(text: "Header")
}
