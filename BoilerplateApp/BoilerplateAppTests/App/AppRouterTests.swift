// AppRouterTests.swift
// Created 21/06/2024.

import BoilerplateApp
import SwiftUI
import XCTest

final class AppRouterTests: XCTestCase {
    func test_init_hasNoSideEffects() {
        let sut = makeSUT()
        XCTAssertTrue(sut.path.isEmpty)
    }

    func test_navigateTo_appendsRouteToPath() {
        let sut = makeSUT()

        let route = UUID()
        sut.navigate(to: route)

        XCTAssertEqual(sut.path.count, 1)
    }

    func test_navigateTo_hasNoSideEffectsOnMultipleCalls() {
        let sut = makeSUT()

        let route = UUID()
        sut.navigate(to: route)
        sut.navigate(to: route)

        XCTAssertEqual(sut.path.count, 2)
    }

    func test_pop_removesTopItemInStack() {
        let sut = makeSUT()

        let route = UUID()
        sut.navigate(to: route)

        XCTAssertEqual(sut.path.count, 1)

        sut.pop()

        XCTAssertTrue(sut.path.isEmpty)
    }
}

private extension AppRouterTests {
    func makeSUT(path: NavigationPath = .init(), file: StaticString = #filePath, line: UInt = #line) -> AppRouter {
        let sut = AppRouter(with: path)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
}
