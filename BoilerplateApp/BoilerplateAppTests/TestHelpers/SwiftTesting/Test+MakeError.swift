//
//  Test+MakeError.swift
//  BoilerplateAppTests
//
//  Created by gordon on 15/09/2026.
//

import Foundation
import Testing

extension Test {
    static func makeError(desc: String = "any error", code: Int = 0) -> NSError {
        let i = [NSLocalizedDescriptionKey: desc]
        return NSError(domain: "test.domain.error", code: code, userInfo: i)
    }
    
    func makeError(desc: String = "any error", code: Int = 0) -> NSError {
        Test.makeError(desc: desc, code: code)
    }
}
