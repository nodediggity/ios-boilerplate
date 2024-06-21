//
//  AppRouterTests.swift
//  BoilerplateAppTests
//
//  Created by Gordon on 21/06/2024.
//

import XCTest
import SwiftUI

class AppRouter {
    var path: [AnyHashable]

    init(with path: [AnyHashable]) {
        self.path = path
    }
    
    func navigate(to destination: AnyHashable) {
        path.append(destination)
    }
    
    func pop() {
        path.removeLast()
    }
}

final class AppRouterTests: XCTestCase {

    func test_init_hasNoSideEffects() {
        let requests = [AnyHashable]()
        XCTAssertTrue(requests.isEmpty)
        
        let sut = AppRouter(with: requests)
        XCTAssertTrue(sut.path.isEmpty)
    }
    
    func test_navigateTo_appendsRouteToPath() {
        let sut = AppRouter(with: [UUID]())
        
        let route = UUID()
        sut.navigate(to: route)
        
        XCTAssertEqual(sut.path, [route])
    }
    
    func test_navigateTo_hasNoSideEffectsOnMultipleCalls() {
        let sut = AppRouter(with: [UUID]())
        
        let route = UUID()
        sut.navigate(to: route)
        sut.navigate(to: route)
        
        XCTAssertEqual(sut.path, [route, route])
    }
    
    func test_pop_removesTopItemInStack() {
        let sut = AppRouter(with: [UUID]())
        
        let route = UUID()
        sut.navigate(to: route)
        
        XCTAssertEqual(sut.path, [route])
        
        sut.pop()
        
        XCTAssertTrue(sut.path.isEmpty)
    }

}
