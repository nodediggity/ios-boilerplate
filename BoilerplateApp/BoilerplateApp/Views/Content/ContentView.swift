// ContentView.swift
// Created 21/06/2024.

import SwiftUI

struct ContentView: View {
    private let router: Router

    init(router: Router) {
        self.router = router
    }

    var body: some View {
        Button(action: { route(to: .details(id: UUID())) }, label: {
            Text("HOME_NAV_LINK")
                .foregroundStyle(Color.primary)
                .fontDesign(.rounded)
                .font(.headline)
                .padding()
        })
    }
}

private extension ContentView {
    func route(to target: Route) {
        router.navigate(to: target)
    }
}

#Preview {
    ContentView(router: AppRouter(with: .init()))
}
