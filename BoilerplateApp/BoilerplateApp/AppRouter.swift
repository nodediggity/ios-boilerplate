//
//  AppRouter.swift
//  BoilerplateApp
//
//  Created by Gordon on 21/06/2024.
//

import Foundation

class AppRouter {
    var path: [AnyHashable]

    init(with path: [AnyHashable]) {
        self.path = path
    }
    
    func navigate(to destination: AnyHashable) {
        path.append(destination)
    }
    
    func pop() {
        path.removeLast()
    }
}
