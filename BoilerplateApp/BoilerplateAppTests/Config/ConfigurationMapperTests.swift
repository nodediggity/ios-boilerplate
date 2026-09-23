// ConfigurationMapperTests.swift
// Created 22/06/2024.

import Foundation
import Testing
@testable import BoilerplateApp

struct ConfigurationMapperTests {
    @Test("Returns the value for a given key")
    func deliversValueForGivenKey() throws {
        let expected = "config value"
        let key = "SOME_CONFIG_VALUE_KEY"
        
        let bundle = MockBundle()
        bundle.values = [key: expected]
        
        let output: String = try ConfigurationMapper.map(key, bundle: bundle)
        
        #expect(output == expected)
    }
    
    @Test("Throws a missing key error when the key does not exist")
    func throwsErrorOnLookUpFailure() {
        let key = "SOME_MISSING_VALUE_KEY"
        let bundle = MockBundle()
        bundle.values = [:]
        
        #expect(
            throws: ConfigurationMapper.Error.missingKey(key)
        ) {
            try ConfigurationMapper.map(key, bundle: bundle) as String
        }
    }
    
    @Test("Throws an invalid value error when the value cannot be mapped to the requested type")
    func throwsErrorOnMapToTypeFailure() {
        let key = "KEY_FOR_INVALID_TYPE"
        let bundle = MockBundle()
        bundle.values = [key: "invalid_type"]
        
        #expect(
            throws: ConfigurationMapper.Error.invalidValue
        ) {
            try ConfigurationMapper.map(key, bundle: bundle) as Bool
        }
    }
}

private extension ConfigurationMapperTests {
    final class MockBundle: Bundle, @unchecked Sendable {
        var values: [String: Any] = [:]
        
        override func object(forInfoDictionaryKey key: String) -> Any? {
            values[key]
        }
    }
}

extension ConfigurationMapper.Error: @retroactive Equatable {
    public static func == (
        lhs: ConfigurationMapper.Error,
        rhs: ConfigurationMapper.Error
    ) -> Bool {
        switch (lhs, rhs) {
        case let (.missingKey(lhsKey), .missingKey(rhsKey)):
            lhsKey == rhsKey
            
        case (.invalidValue, .invalidValue):
            true
            
        default:
            false
        }
    }
}
