// ConfigurationMapperTests.swift
// Created 22/06/2024.

import XCTest
@testable import BoilerplateApp

final class ConfigurationMapperTests: XCTestCase {
    func test_deliversValueForGivenKey() throws {
        let expected = "config value"
        let key = "SOME_CONFIG_VALUE_KEY"

        let bundle = MockBundle()
        bundle.values = [key: expected]

        let output: String = try ConfigurationMapper.map(key, bundle: bundle)

        XCTAssertEqual(output, expected)
    }

    func test_throwsErrorOnLookUpFailure() {
        let key = "SOME_MISSING_VALUE_KEY"
        let bundle = MockBundle()
        bundle.values = [String: String]()

        XCTAssertThrows(
            expression: try ConfigurationMapper.map(key, bundle: bundle) as String,
            error: ConfigurationMapper.Error.missingKey(key)
        )
    }

    func test_throwsErrorOnMapToTypeFailure() {
        let key = "KEY_FOR_INVALID_TYPE"
        let bundle = MockBundle()
        bundle.values = [key: "invalid_type"]

        XCTAssertThrows(
            expression: try ConfigurationMapper.map(key, bundle: bundle) as Bool,
            error: ConfigurationMapper.Error.invalidValue
        )
    }
}

private extension ConfigurationMapperTests {
    class MockBundle: Bundle {
        var values: [String: Any] = [:]
        override func object(forInfoDictionaryKey key: String) -> Any? {
            if let value = values[key] {
                return value
            }

            return nil
        }
    }
}

extension ConfigurationMapper.Error: Equatable {
    public static func == (lhs: ConfigurationMapper.Error, rhs: ConfigurationMapper.Error) -> Bool {
        switch (lhs, rhs) {
        case let (.missingKey(lhsKey), .missingKey(rhsKey)):
            return lhsKey == rhsKey
        case (.invalidValue, .invalidValue):
            return true
        default: return false
        }
    }
}
