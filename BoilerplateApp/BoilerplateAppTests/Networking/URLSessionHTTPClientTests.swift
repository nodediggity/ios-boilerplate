// URLSessionHTTPClientTests.swift
// Created 21/06/2024.

import BoilerplateApp
import Foundation
import Testing

@Suite("URL Session HTTP Client", .serialized)
struct URLSessionHTTPClientTests {
    
    @Test("Dispatch delivers error on request failure")
    func dispatchDeliversErrorOnRequestFailure() async {
        let fixtures = TestFixtures()
        
        let error = Test.makeError()
        let receivedError = await fixtures.resultErrorFor(data: nil, response: nil, error: error)
        
        #expect(receivedError != nil)
    }
    
    @Test("Dispatch delivers error on invalid representation cases")
    func dispatchDeliversErrorOnInvalidRepresentationCases() async {
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
        
        let fixtures = TestFixtures()
        
        let nonHTTPURLResponse = URLResponse(url: Test.makeURL(), mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
        let httpResponse = HTTPURLResponse(url: Test.makeURL(), statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let data = Test.makeData()
        let error = Test.makeError()
        
        let errors = [
            await fixtures.resultErrorFor(data: nil, response: nonHTTPURLResponse, error: nil),
            await fixtures.resultErrorFor(data: data, response: nil, error: error),
            await fixtures.resultErrorFor(data: nil, response: nonHTTPURLResponse, error: error),
            await fixtures.resultErrorFor(data: nil, response: httpResponse, error: error),
            await fixtures.resultErrorFor(data: data, response: nonHTTPURLResponse, error: error),
            await fixtures.resultErrorFor(data: data, response: httpResponse, error: error),
            await fixtures.resultErrorFor(data: data, response: nonHTTPURLResponse, error: nil)
        ]
        
        for error in errors {
            #expect(error != nil)
        }
    }
    
    @Test("Dispatch performs request with given object")
    func dispatchPerformsRequestWithGivenObject() async throws {
        let fixtures = TestFixtures()
        let sut = fixtures.makeSUT()
        
        let requestID = UUID().uuidString
        let requestURL = Test.makeURL()
        
        var request = URLRequest(url: requestURL)
        request.addValue(requestID, forHTTPHeaderField: "REQUEST_ID")
        
        let httpResponse = HTTPURLResponse(url: requestURL, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let data = Test.makeData()
        
        URLProtocolStub.stub(data: data, response: httpResponse, error: nil)
        
        _ = try await sut.dispatch(request)
        
        #expect(URLProtocolStub.observedRequests.count == 1)
        fixtures.expectRequest(at: 0, toEqual: request)
    }
    
    @Test("Dispatch delivers success on HTTPURLResponse with data")
    func dispatchDeliversSuccessOnHTTPURLResponseWithData() async {
        let fixtures = TestFixtures()
        
        let data = Test.makeData()
        let httpResponse = HTTPURLResponse(url: Test.makeURL(), statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let output = await fixtures.resultValuesFor(data: data, response: httpResponse, error: nil)
        
        #expect(output?.data == data)
        #expect(output?.response.url == httpResponse?.url)
        #expect(output?.response.statusCode == httpResponse?.statusCode)
    }
    
    @Test("Dispatch delivers success with empty data on HTTPURLResponse with missing data")
    func dispatchDeliversSuccessWithEmptyDataOnHTTPURLResponseWithMissingData() async {
        let fixtures = TestFixtures()
        
        let emptyData = Test.makeData()
        let httpResponse = HTTPURLResponse(url: Test.makeURL(), statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let output = await fixtures.resultValuesFor(data: nil, response: httpResponse, error: nil)
        
        #expect(output?.data == emptyData)
        #expect(output?.response.url == httpResponse?.url)
        #expect(output?.response.statusCode == httpResponse?.statusCode)
    }
}

extension URLSessionHTTPClientTests {
    final class TestFixtures {
        
        private var sutTracker: MemoryLeakTracker<URLSessionHTTPClient>?
        
        deinit {
            URLProtocolStub.removeStub()
            sutTracker?.verify()
        }
        
        func makeSUT(sourceLocation: SourceLocation = #_sourceLocation) -> URLSessionHTTPClient {
            let configuration = URLSessionConfiguration.ephemeral
            configuration.protocolClasses = [URLProtocolStub.self]
            
            let session = URLSession(configuration: configuration)
            let sut = URLSessionHTTPClient(session: session)
            
            sutTracker = .init(instance: sut, sourceLocation: sourceLocation)
            
            return sut
        }
        
        func expectRequest(at index: Int, toEqual expected: URLRequest, sourceLocation: SourceLocation = #_sourceLocation) {
            let captured = URLProtocolStub.observedRequests[index]
            
            #expect(captured.url == expected.url, sourceLocation: sourceLocation)
            #expect(captured.allHTTPHeaderFields == expected.allHTTPHeaderFields, sourceLocation: sourceLocation)
        }
        
        func resultErrorFor(data: Data?, response: URLResponse?, error: Error?, sourceLocation: SourceLocation = #_sourceLocation) async -> Error? {
            URLProtocolStub.stub(data: data, response: response, error: error)
            
            let sut = makeSUT(sourceLocation: sourceLocation)
            
            do {
                let request = URLRequest(url: Test.makeURL())
                _ = try await sut.dispatch(request)
                
                Issue.record(
                    "Expected failure but got success instead",
                    sourceLocation: sourceLocation
                )
                
                return nil
            } catch {
                return error
            }
        }
        
        func resultValuesFor(data: Data?, response: URLResponse?, error: Error?, sourceLocation: SourceLocation = #_sourceLocation) async -> (data: Data, response: HTTPURLResponse)? {
            URLProtocolStub.stub(data: data, response: response, error: error)
            
            let sut = makeSUT(sourceLocation: sourceLocation)
            
            do {
                let request = URLRequest(url: Test.makeURL())
                return try await sut.dispatch(request)
            } catch {
                Issue.record(
                    "Expected success but got failure instead",
                    sourceLocation: sourceLocation
                )
                
                return nil
            }
        }
    }
}
