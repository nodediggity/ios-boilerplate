//
//  Test+MakeData.swift
//  BoilerplateAppTests
//
//  Created by gordon on 15/09/2026.
//

import Foundation
import Testing

extension Test {
    static func makeData<T: Encodable>(obj: T? = .none) -> Data {
        guard let obj else { return Data() }
        return try! JSONEncoder().encode(obj)
    }
    
    func makeData<T: Encodable>(obj: T? = .none) -> Data {
        Test.makeData(obj: obj)
    }
}
