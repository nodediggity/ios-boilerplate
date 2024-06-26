// URLSessionHTTPClientTests.swift
// Created 21/06/2024.

import BoilerplateApp
import XCTest

final class URLSessionHTTPClientTests: XCTestCase {
    override func tearDown() {
        super.tearDown()
        URLProtocolStub.removeStub()
    }

    func test_dispatch_deliversErrorOnRequestFailure() async {
        let error = makeError()
        let receivedError = await resultErrorFor(data: nil, response: nil, error: error)
        XCTAssertNotNil(receivedError)
    }

    func test_dispatch_deliversErrorOnInvalidRepresentationCases() async {
        /*
           These cases should *never* happen, however as `URLSession` represents these fields as optional
           it is possible in some obscure way that this state _could_ exist.

           | Data?    | URLResponse?      | Error?   |
           |----------|-------------------|----------|
           | nil      | URLResponse       | nil      |
           | value    | nil               | value    |
           | nil      | URLResponse       | value    |
           | nil      | HTTPURLResponse   | value    |
           | value    | HTTPURLResponse   | value    |
           | value    | URLResponse       | nil      |
         */

        let nonHTTPURLResponse = URLResponse(url: makeURL(), mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
        let httpResponse = HTTPURLResponse(url: makeURL(), statusCode: 200, httpVersion: nil, headerFields: nil)
        let data = makeData()
        let error = makeError()

        let requests = await [
            resultErrorFor(data: nil, response: nonHTTPURLResponse, error: nil),
            resultErrorFor(data: data, response: nil, error: error),
            resultErrorFor(data: nil, response: nonHTTPURLResponse, error: error),
            resultErrorFor(data: nil, response: httpResponse, error: error),
            resultErrorFor(data: data, response: nonHTTPURLResponse, error: error),
            resultErrorFor(data: data, response: httpResponse, error: error),
            resultErrorFor(data: data, response: nonHTTPURLResponse, error: nil)
        ]

        for (index, element) in requests.enumerated() {
            XCTAssertNotNil(element, "Expected error for item at \(index) but got nil instead")
        }
    }

    func test_dispatch_performsRequestWithGivenObject() async throws {
        let requestID = UUID().uuidString
        let sut = makeSUT()

        let requestURL = makeURL()
        var request = URLRequest(url: requestURL)
        request.addValue(requestID, forHTTPHeaderField: "REQUEST_ID")

        let httpResponse = HTTPURLResponse(url: requestURL, statusCode: 200, httpVersion: nil, headerFields: nil)
        let data = makeData()

        URLProtocolStub.stub(data: data, response: httpResponse, error: .none)

        _ = try await sut.dispatch(request)

        XCTAssertEqual(URLProtocolStub.observedRequests.count, 1)
        expectRequest(at: 0, toEqual: request)
    }

    func test_dispatch_deliversSuccessOnHTTPURLResponseWithData() async {
        let data = makeData()
        let httpResponse = HTTPURLResponse(url: makeURL(), statusCode: 200, httpVersion: nil, headerFields: nil)
        let output = await resultValuesFor(data: data, response: httpResponse, error: nil)

        XCTAssertEqual(output?.data, data)
        XCTAssertEqual(output?.response.url, httpResponse?.url)
        XCTAssertEqual(output?.response.statusCode, httpResponse?.statusCode)
    }

    func test_dispatch_deliversSuccessWithEmptyDataOnHTTPURLResponseWithMissingData() async {
        let emptyData = makeData()
        let httpResponse = HTTPURLResponse(url: makeURL(), statusCode: 200, httpVersion: nil, headerFields: nil)
        let output = await resultValuesFor(data: nil, response: httpResponse, error: nil)

        XCTAssertEqual(output?.data, emptyData)
        XCTAssertEqual(output?.response.url, httpResponse?.url)
        XCTAssertEqual(output?.response.statusCode, httpResponse?.statusCode)
    }
}

private extension URLSessionHTTPClientTests {
    func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> URLSessionHTTPClient {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]

        let session = URLSession(configuration: configuration)
        let sut = URLSessionHTTPClient(session: session)

        trackForMemoryLeaks(session, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)

        return sut
    }

    func expectRequest(at index: Int, toEqual expected: URLRequest, file: StaticString = #filePath, line: UInt = #line) {
        let captured = URLProtocolStub.observedRequests[index]
        XCTAssertEqual(captured.url, expected.url, file: file, line: line)
        XCTAssertEqual(captured.allHTTPHeaderFields, expected.allHTTPHeaderFields, file: file, line: line)
    }

    func resultErrorFor(data: Data?, response: URLResponse?, error: Error?, file: StaticString = #filePath, line: UInt = #line) async -> Error? {
        URLProtocolStub.stub(data: data, response: response, error: error)
        let sut = makeSUT(file: file, line: line)
        do {
            let requestURL = makeURL()
            let request = URLRequest(url: requestURL)
            _ = try await sut.dispatch(request)
            XCTFail("Expected failure but got success instead", file: file, line: line)
            return nil
        } catch {
            return error
        }
    }

    func resultValuesFor(data: Data?, response: URLResponse?, error: Error?, file: StaticString = #filePath, line: UInt = #line) async -> (data: Data, response: HTTPURLResponse)? {
        URLProtocolStub.stub(data: data, response: response, error: error)
        let sut = makeSUT(file: file, line: line)
        do {
            let requestURL = makeURL()
            let request = URLRequest(url: requestURL)
            return try await sut.dispatch(request)
        } catch {
            XCTFail("Expected success but got failure instead", file: file, line: line)
            return nil
        }
    }
}
