// XCTestCase+ThrownErrors.swift
// Created 22/06/2024.

import XCTest

public extension XCTestCase {
    func XCTAssertThrows<E: Error>(expression: @autoclosure () throws -> some Any, error expected: E, file: StaticString = #filePath, line: UInt = #line) where E: Equatable {
        do {
            _ = try expression()
            XCTFail("Expected error but got success", file: file, line: line)
        } catch let caughtError as E {
            XCTAssertEqual(caughtError, expected, file: file, line: line)
        } catch {
            XCTFail("Expected \(String(describing: expected)) but got \(String(describing: error))", file: file, line: line)
        }
    }
}
