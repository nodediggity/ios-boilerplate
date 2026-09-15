// AppRouterTests.swift
// Created 21/06/2024.

import BoilerplateApp
import SwiftUI
import Testing
import XCTest

@Suite("App Router")
struct AppRouterTests {
    
    @Test("Does not update path on init")
    func initHasNoSideEffects() {
        let fixtures = TestFixtures()
        
        let emptyPath = NavigationPath()
        let sut = fixtures.makeSUT(path: emptyPath)
        
        #expect(sut.path.isEmpty)
    }
    
    @Test("Navigate action updates path")
    func navigateAppendsRouteToPath() {
        let fixtures = TestFixtures()
        let sut = fixtures.makeSUT()
        
        let path = UUID()
        sut.navigate(to: path)

        #expect(sut.path.count == 1)
    }
}

extension AppRouterTests {
    final class TestFixtures {
        func makeSUT(path: NavigationPath = .init()) -> AppRouter {
            AppRouter(with: path)
        }
    }
}

final class AppRouterXCTestCases: XCTestCase {

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

private extension AppRouterXCTestCases {
    func makeSUT(path: NavigationPath = .init(), file: StaticString = #filePath, line: UInt = #line) -> AppRouter {
        let sut = AppRouter(with: path)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
}
