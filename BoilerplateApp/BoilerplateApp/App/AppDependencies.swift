// AppDependencies.swift
// Created 21/06/2024.

import Foundation

final class AppDependencies {
    private lazy var httpClient: HTTPClient = {
        let session = URLSession(configuration: .ephemeral)
        return URLSessionHTTPClient(session: session)
    }()
}
