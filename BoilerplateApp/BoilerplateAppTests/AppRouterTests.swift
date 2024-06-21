//
//  AppRouterTests.swift
//  BoilerplateAppTests
//
//  Created by Gordon on 21/06/2024.
//

import XCTest
import SwiftUI

class AppRouter {
    var path: NavigationPath

    init(with path: NavigationPath) {
        self.path = path
    }
}


final class AppRouterTests: XCTestCase {

    func test_init_hasNoSideEffects() {
        let stub = NavigationPath()
        XCTAssertTrue(stub.isEmpty)
        
        _ = AppRouter(with: stub)
        XCTAssertTrue(stub.isEmpty)
    }

}
