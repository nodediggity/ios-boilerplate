//
//  Test+MakeData.swift
//  BoilerplateAppTests
//
//  Created by gordon on 15/09/2026.
//

import Foundation
import Testing

extension Test {
    static func makeData(str: String? = .none) -> Data {
        guard let str else { return Data() }
        return Data(str.utf8)
    }
    
    func makeData(str: String? = .none) -> Data {
        Test.makeData(str: str)
    }
}
