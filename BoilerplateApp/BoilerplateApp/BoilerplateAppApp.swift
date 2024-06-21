//
//  BoilerplateAppApp.swift
//  BoilerplateApp
//
//  Created by Gordon on 21/06/2024.
//

import SwiftUI

@main
struct BoilerplateAppApp: App {
    
    @State private var router: Router = AppRouter()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path, root: {
                ContentView(router: router)
                    .navigationDestination(for: ContentView.Route.self, destination: { route in
                        switch route {
                            case let .details(id): DetailView(id: id)
                        }
                    })
            })
        }
    }
}
