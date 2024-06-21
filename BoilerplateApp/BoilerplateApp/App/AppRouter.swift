//
//  AppRouter.swift
//  BoilerplateApp
//
//  Created by Gordon on 21/06/2024.
//

import Foundation
import SwiftUI

public protocol Router {
    var path: NavigationPath { get set }
    func navigate(to destination: any Hashable)
    func pop()
}

@Observable
public final class AppRouter: Router {
    public var path: NavigationPath

    public init(with path: NavigationPath = NavigationPath()) {
        self.path = path
    }
    
    public func navigate(to destination: any Hashable) {
        path.append(destination)
    }
    
    public func pop() {
        path.removeLast()
    }
}
