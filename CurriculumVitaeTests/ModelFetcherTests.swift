//
//  ModelFetcherTests.swift
//  CurriculumVitaeTests
//
//  Created by Michael Voong on 25/01/2019.
//  Copyright © 2019 Meidi Limited. All rights reserved.
//

import XCTest
@testable import CurriculumVitae

class ModelFetcherTests: XCTestCase {
    
    struct ExampleDecodable: Decodable {
        
        let string: String
    }

    let stubRequestExecuter = StubRequestExecuter()
    let exampleURL = URL(string: "https://example.com")!
    
    func testFetchCallsrequestDataWithCorrectURL() {
        let fetcher = ModelFetcher(requestExecuter: self.stubRequestExecuter)
        
        fetcher.fetch(type: ExampleDecodable.self, url: self.exampleURL) { _ in }
        
        XCTAssertEqual(self.stubRequestExecuter.requestDataCalled?.url, self.exampleURL)
    }
    
    func testFetchCallsCompletionWithNetworkError() {
        let fetcher = ModelFetcher(requestExecuter: self.stubRequestExecuter)
        let error = NSError(domain: "", code: 0, userInfo: nil)
        
        var completionCalledWithResult: Result<ExampleDecodable, ModelFetcher.ModelFetcherError>?
        fetcher.fetch(type: ExampleDecodable.self, url: self.exampleURL) { result in
            completionCalledWithResult = result
        }
        self.stubRequestExecuter.requestDataCalled?.completion(.failure(.foundationError(error)))
        
        if case .failure(let error)? = completionCalledWithResult {
            XCTAssertEqual(error, .networkError)
        } else {
            XCTFail()
        }
    }
    
    func testFetchCallsCompletionWithDecodedModel() {
        let fetcher = ModelFetcher(requestExecuter: self.stubRequestExecuter)
        let json = """
{ "string": "Example string" }
"""
        let data = json.data(using: .utf8)!
        
        var completionCalledWithResult: Result<ExampleDecodable, ModelFetcher.ModelFetcherError>?
        fetcher.fetch(type: ExampleDecodable.self, url: self.exampleURL) { result in
            completionCalledWithResult = result
        }
        self.stubRequestExecuter.requestDataCalled?.completion(.success(data))
        
        if case .success(let object)? = completionCalledWithResult {
            XCTAssertEqual(object.string, "Example string")
        }
    }
    
    func testFetchCallsCompletionWithDecodingError() {
        let fetcher = ModelFetcher(requestExecuter: self.stubRequestExecuter)
        let data = "".data(using: .utf8)!
        
        var completionCalledWithResult: Result<ExampleDecodable, ModelFetcher.ModelFetcherError>?
        fetcher.fetch(type: ExampleDecodable.self, url: self.exampleURL) { result in
            completionCalledWithResult = result
        }
        self.stubRequestExecuter.requestDataCalled?.completion(.success(data))
        
        if case .failure(let error)? = completionCalledWithResult {
            XCTAssertEqual(error, .decodingError)
        }
    }

}
