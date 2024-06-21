//
//  URLSessionHTTPClient.swift
//  BoilerplateApp
//
//  Created by Gordon on 21/06/2024.
//

import Foundation

public protocol HTTPClient {
    typealias Resource = (data: Data, response: HTTPURLResponse)
    /// This method can be invoked in any thread.
    /// Clients are responsible for dispatch to appropriate threads, if needed.
    func dispatch(_ request: URLRequest) async throws -> Resource
}

public final class URLSessionHTTPClient: HTTPClient {
    public typealias Resource = HTTPClient.Resource
    private let session: URLSession

    public init(session: URLSession) {
        self.session = session
    }

    private struct UnexpectedValuesRepresentation: Error { }

    public func dispatch(_ request: URLRequest) async throws -> Resource {
        let (data, response) = try await session.data(for: request)

        if let response = response as? HTTPURLResponse {
            return (data, response)
        }

        throw UnexpectedValuesRepresentation()
    }
}
