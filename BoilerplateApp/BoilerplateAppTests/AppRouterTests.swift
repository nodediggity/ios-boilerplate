//
//  AppRouterTests.swift
//  BoilerplateAppTests
//
//  Created by Gordon on 21/06/2024.
//

import XCTest
import SwiftUI
import BoilerplateApp

final class AppRouterTests: XCTestCase {
    
    func test_init_hasNoSideEffects() {
        let requests = [AnyHashable]()
        let sut = makeSUT(path: requests)
        XCTAssertTrue(sut.path.isEmpty)
    }
    
    func test_navigateTo_appendsRouteToPath() {
        let sut = makeSUT(path: [UUID]())
        
        let route = UUID()
        sut.navigate(to: route)
        
        XCTAssertEqual(sut.path, [route])
    }
    
    func test_navigateTo_hasNoSideEffectsOnMultipleCalls() {
        let sut = makeSUT(path: [UUID]())

        let route = UUID()
        sut.navigate(to: route)
        sut.navigate(to: route)
        
        XCTAssertEqual(sut.path, [route, route])
    }
    
    func test_pop_removesTopItemInStack() {
        let sut = makeSUT(path: [UUID]())

        let route = UUID()
        sut.navigate(to: route)
        
        XCTAssertEqual(sut.path, [route])
        
        sut.pop()
        
        XCTAssertTrue(sut.path.isEmpty)
    }
    
}

private extension AppRouterTests {
    func makeSUT(path: [AnyHashable] = [UUID](), file: StaticString = #filePath, line: UInt = #line) -> AppRouter {
        let sut = AppRouter(with: path)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
}
