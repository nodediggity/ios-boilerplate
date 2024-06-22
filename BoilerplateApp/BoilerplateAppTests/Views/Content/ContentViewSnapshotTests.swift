// ContentViewSnapshotTests.swift
// Created 22/06/2024.

import SwiftUI
import XCTest
@testable import BoilerplateApp

final class ContentViewSnapshotTests: XCTestCase {
    func test_loaded() {
        let sut = makeSUT()
        assert(snapshot: sut.snapshot(for: .iPhone15Pro(style: .light)), named: "CONTENT_VIEW_LOADED_light")
    }
}

private extension ContentViewSnapshotTests {
    func makeSUT() -> UIViewController {
        let rootView = ContentView(router: StubRouter())
        let controller = UIHostingController(rootView: rootView)
        return controller
    }
}
