//
//  MemoryLeak+Tracker.swift
//  BoilerplateAppTests
//
//  Created by gordon on 15/09/2026.
//

import Foundation
import Testing

struct MemoryLeakTracker<T: AnyObject> {
    weak var instance: T?
    var sourceLocation: SourceLocation
    
    func verify() {
        #expect(instance == nil, "Expected \(instance!) to be deallocated. Potential memory leak", sourceLocation: sourceLocation)
    }
}
