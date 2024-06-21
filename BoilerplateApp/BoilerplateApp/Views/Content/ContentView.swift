//
//  ContentView.swift
//  BoilerplateApp
//
//  Created by Gordon on 21/06/2024.
//

import SwiftUI

struct ContentView: View {
    
    private let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    var body: some View {
        Button(action: { route(to: .details(id: UUID())) }, label: {
            Text("Show details")
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
