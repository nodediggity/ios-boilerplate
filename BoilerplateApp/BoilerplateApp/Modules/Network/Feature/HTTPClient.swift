// HTTPClient.swift
// Created 21/06/2024.

import Foundation

public protocol HTTPClient {
    typealias Resource = (data: Data, response: HTTPURLResponse)
    /// This method can be invoked in any thread.
    /// Clients are responsible for dispatch to appropriate threads, if needed.
    func dispatch(_ request: URLRequest) async throws -> Resource
}
