//
//  ContentView+Route.swift
//  BoilerplateApp
//
//  Created by Gordon on 21/06/2024.
//

import SwiftUI

extension ContentView {
    enum Route: Hashable {
        case details(id: UUID)
    }
}
