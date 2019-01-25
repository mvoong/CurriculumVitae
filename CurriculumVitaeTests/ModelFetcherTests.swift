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
    
    func testFetchCallsRequestJSONWithCorrectURL() {
        let fetcher = ModelFetcher(requestExecuter: self.stubRequestExecuter)
        
        fetcher.fetch(type: ExampleDecodable.self, url: self.exampleURL) { _, _ in }
        
        XCTAssertEqual(self.stubRequestExecuter.requestJSONCalled?.url, self.exampleURL)
    }
    
    func testFetchCallsCompletionWithNetworkError() {
        let fetcher = ModelFetcher(requestExecuter: self.stubRequestExecuter)
        let error = NSError(domain: "", code: 0, userInfo: nil)
        
        var completionCalledWithError: ModelFetcherError?
        fetcher.fetch(type: ExampleDecodable.self, url: self.exampleURL) { _, error in
            completionCalledWithError = error
        }
        self.stubRequestExecuter.requestJSONCalled?.completion(nil, error)
        
        XCTAssertEqual(completionCalledWithError, ModelFetcherError.networkError)
    }
    
    func testFetchCallsCompletionWithDecodedModel() {
        let fetcher = ModelFetcher(requestExecuter: self.stubRequestExecuter)
        let json = """
{ "string": "Example string" }
"""
        
        var completionCalledWithModel: ExampleDecodable?
        fetcher.fetch(type: ExampleDecodable.self, url: self.exampleURL) { model, _ in
            completionCalledWithModel = model
        }
        self.stubRequestExecuter.requestJSONCalled?.completion(json.data(using: .utf8), nil)
        
        XCTAssertEqual(completionCalledWithModel?.string, "Example string")
    }
    
    func testFetchCallsCompletionWithDecodingError() {
        let fetcher = ModelFetcher(requestExecuter: self.stubRequestExecuter)
        
        var completionCalledWithError: ModelFetcherError?
        fetcher.fetch(type: ExampleDecodable.self, url: self.exampleURL) { _, error in
            completionCalledWithError = error
        }
        self.stubRequestExecuter.requestJSONCalled?.completion("".data(using: .utf8), nil)
        
        XCTAssertEqual(completionCalledWithError, ModelFetcherError.decodingError)
    }

}
