//
//  XCTestCase+MakeError.swift
//  BoilerplateAppTests
//
//  Created by Gordon on 21/06/2024.
//

import XCTest

extension XCTestCase {
    func makeError(desc: String = "any error", code: Int = 0) -> NSError {
        XCTestCase.makeError(desc: desc, code: code)
    }

    static func makeError(desc: String = "any error", code: Int = 0) -> NSError {
        let userInfo = [NSLocalizedDescriptionKey: desc]
        return NSError(domain: "test.domain.error", code: code, userInfo: userInfo)
    }
}
