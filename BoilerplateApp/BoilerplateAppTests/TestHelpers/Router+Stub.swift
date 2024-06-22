// Router+Stub.swift
// Created 22/06/2024.

import BoilerplateApp
import SwiftUI

class StubRouter: Router {
    var path: NavigationPath
    func navigate(to destination: any Hashable) { }
    func pop() { }

    init() {
        path = .init()
    }
}
