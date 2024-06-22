// XCTestCase+MakeURL.swift
// Created 21/06/2024.

import XCTest

extension XCTestCase {
    func makeURL(addr: String = "http://domain.tld") -> URL {
        XCTestCase.makeURL(addr: addr)
    }

    static func makeURL(addr: String = "http://domain.tld") -> URL {
        URL(string: addr)!
    }
}
