// BoilerplateAppApp.swift
// Created 21/06/2024.

import SwiftUI

@main
struct BoilerplateAppApp: App {
    @State private var router = AppRouter()
    @State private var dependencies = AppDependencies()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path, root: {
                ContentView(router: router)
                    .navigationDestination(for: ContentView.Route.self, destination: { route in
                        switch route {
                        case let .details(id): DetailsView(id: id)
                        }
                    })
            })
        }
    }
}
