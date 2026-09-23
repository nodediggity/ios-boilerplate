//
//  Test+MakeURL.swift
//  BoilerplateAppTests
//
//  Created by gordon on 15/09/2026.
//

import Foundation
import Testing

extension Test {
    static func makeURL(addr: String = "http://domain.tld") -> URL {
        URL(string: addr)!
    }
    
    func makeURL(addr: String = "http://domain.tld") -> URL {
        Test.makeURL(addr: addr)
    }
}
