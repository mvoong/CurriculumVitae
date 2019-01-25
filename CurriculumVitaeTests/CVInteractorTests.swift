//
//  CVInteractorTests.swift
//  CurriculumVitaeTests
//
//  Created by Michael Voong on 25/01/2019.
//  Copyright © 2019 Meidi Limited. All rights reserved.
//

import XCTest
@testable import CurriculumVitae

class CVInteractorTests: XCTestCase {

    let stubModelFetcher = StubModelFetcher()
    
    func testRequestCVCallsFetchOnModel() {
        let interactor = CVInteractor(modelFetcher: self.stubModelFetcher)
        
        interactor.requestCV { _ in }
        
        XCTAssertEqual(self.stubModelFetcher.fetchCalled?.url.absoluteString, "https://gist.githubusercontent.com/mvoong/c1e2368376c9b91b9e0cb6061f194526/raw/028ff182decbd95257a35e6d662e5dc6e68c7a29/cv.json")
    }
    
    func testRequestCVCallsCompletion() {
        let interactor = CVInteractor(modelFetcher: self.stubModelFetcher)
        let cv = CurriculumVitae(summary: "Summary", topics: "", pastExperience: [])
        
        var completionCalledWithCV: CurriculumVitae?
        interactor.requestCV { cv in
            completionCalledWithCV = cv
        }
        self.stubModelFetcher.fetchCalled?.completion(cv, nil)
        
        XCTAssertNotNil(completionCalledWithCV)
    }
    
    func testRequestCVDoesNotCallsCompletion() {
        let interactor = CVInteractor(modelFetcher: self.stubModelFetcher)
        
        var completionCalled = false
        interactor.requestCV { cv in
            completionCalled = true
        }
        self.stubModelFetcher.fetchCalled?.completion(nil, nil)
        
        XCTAssertFalse(completionCalled)
    }
    
    // Integration tests
    
    func testRequestCVFetchesFromRemoteServer() {
        let expectation = self.expectation(description: #function)
        let interactor = CVInteractor(modelFetcher: ModelFetcher(requestExecuter: RequestExecuter()))
        
        interactor.requestCV { _ in
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
    }
}
