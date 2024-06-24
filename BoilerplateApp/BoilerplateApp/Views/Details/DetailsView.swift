// DetailsView.swift
// Created 21/06/2024.

import SwiftUI

struct DetailsView: View {
    private let id: UUID

    init(id: UUID) {
        self.id = id
    }

    var body: some View {
        Text("DETAILS_USER_ID \(id.uuidString)")
            .font(.largeTitle)
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .accessibilityLabel("DETAILS_USER_ID_ACC_LABEL")
            .accessibilityValue(id.uuidString)
            .accessibilityHint("DETAILS_USER_ID_DESC")
            .accessibilityIdentifier("DETAILS_USER_ID_TEXT")
    }
}

#Preview {
    DetailsView(id: UUID())
}
