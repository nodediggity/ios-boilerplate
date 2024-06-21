//
//  AppDependencies.swift
//  BoilerplateApp
//
//  Created by Gordon on 21/06/2024.
//

import Foundation

final class AppDependencies {
    
    private lazy var httpClient: HTTPClient = {
        URLSessionHTTPClient(session: .init(configuration: .ephemeral))
    }()
    
}
