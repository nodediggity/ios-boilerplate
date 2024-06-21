//
//  AppRouter.swift
//  BoilerplateApp
//
//  Created by Gordon on 21/06/2024.
//

import Foundation

public final class AppRouter {
    public var path: [AnyHashable]

    public init(with path: [AnyHashable]) {
        self.path = path
    }
    
    public func navigate(to destination: AnyHashable) {
        path.append(destination)
    }
    
    public func pop() {
        path.removeLast()
    }
}
