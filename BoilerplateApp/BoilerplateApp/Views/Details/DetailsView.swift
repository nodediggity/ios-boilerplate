//
//  DetailsView.swift
//  BoilerplateApp
//
//  Created by Gordon on 21/06/2024.
//

import SwiftUI

struct DetailsView: View {
    
    private let id: UUID
    
    init(id: UUID) {
        self.id = id
    }
    
    var body: some View {
        Text("\(id.uuidString)")
            .font(.largeTitle)
            .padding()
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    DetailsView(id: UUID())
}
