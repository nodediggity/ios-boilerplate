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
    
    @Test("Navigate action updates path on multiple actions")
    func noSideEffectsOnMultipleActions() {
        let fixtures = TestFixtures()
        let sut = fixtures.makeSUT()
        
        sut.navigate(to: UUID())
        sut.navigate(to: UUID())

        #expect(sut.path.count == 2)
    }
    
    @Test("Pop action drops item from stacvk")
    func removesItemInStack() {
        let fixtures = TestFixtures()
        let sut = fixtures.makeSUT()
        
        sut.navigate(to: UUID())
        sut.pop()
        
        #expect(sut.path.isEmpty)
    }
}

extension AppRouterTests {
    final class TestFixtures {
        func makeSUT(path: NavigationPath = .init()) -> AppRouter {
            AppRouter(with: path)
        }
    }
}
