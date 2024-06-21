//
//  URLSessionHTTPClient.swift
//  BoilerplateApp
//
//  Created by Gordon on 21/06/2024.
//

import Foundation

public final class URLSessionHTTPClient {
    public typealias Resource = (data: Data, response: HTTPURLResponse)
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
