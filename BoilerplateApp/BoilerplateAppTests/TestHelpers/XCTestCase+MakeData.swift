//
//  XCTestCase+MakeData.swift
//  BoilerplateAppTests
//
//  Created by Gordon on 21/06/2024.
//

import XCTest

extension XCTestCase {
    
    func makeData(str: String? = .none) -> Data {
        XCTestCase.makeData(str: str)
    }

    static func makeData(str: String? = .none) -> Data {
        guard let str = str else { return Data() }
        return Data(str.utf8)
    }
}
