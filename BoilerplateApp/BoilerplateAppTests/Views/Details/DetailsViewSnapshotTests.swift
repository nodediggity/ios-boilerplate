// DetailsViewSnapshotTests.swift
// Created 24/06/2024.

import SwiftUI
import XCTest
@testable import BoilerplateApp

final class DetailsViewSnapshotTests: XCTestCase {
    func test_loaded() {
        let sut = makeSUT()
        assert(snapshot: sut.snapshot(for: .iPhone15Pro(style: .light)), named: "DETAILS_VIEW_LOADED_light")
    }
}

private extension DetailsViewSnapshotTests {
    func makeSUT() -> UIViewController {
        let fixedId = UUID(uuidString: "6A967474-8672-4ABC-A57B-52EA809C5E6D")!
        let rootView = DetailsView(id: fixedId)
        let controller = UIHostingController(rootView: rootView)
        return controller
    }
}
