//
//  DetailView.swift
//  BoilerplateApp
//
//  Created by Gordon on 21/06/2024.
//

import SwiftUI

struct DetailView: View {
    
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
    DetailView(id: UUID())
}
