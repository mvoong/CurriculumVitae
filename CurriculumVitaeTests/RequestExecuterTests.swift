//
//  RequestExecuterTests.swift
//  CurriculumVitaeTests
//
//  Created by Michael Voong on 25/01/2019.
//  Copyright © 2019 Meidi Limited. All rights reserved.
//

import XCTest
@testable import CurriculumVitae

class RequestExecuterTests: XCTestCase {

    let stubURLSession = StubURLSession()
    
    func testRequestJSONCreatesDataTaskWithCorrectURL() {
        let executer = RequestExecuter(urlSession: self.stubURLSession)
        
        executer.requestJSON(url: URL(string: "https://www.example.com")!) { _, _ in }
        
        XCTAssertEqual(self.stubURLSession.dataTaskCalled?.url.absoluteString, "https://www.example.com")
    }
    
    func testRequestJSONCallsResumeOnDataTask() {
        let executer = RequestExecuter(urlSession: self.stubURLSession)
        
        executer.requestJSON(url: URL(string: "https://www.example.com")!) { _, _ in }
        
        XCTAssertTrue(self.stubURLSession.spyDataTask.resumeCalled)
    }
    
    func testRequestJSONCallsCompletionWithError() {
        let executer = RequestExecuter(urlSession: self.stubURLSession)
        var completionCalledWithError: NSError?
        let raisedError = NSError(domain: "", code: 0, userInfo: nil)
        
        executer.requestJSON(url: URL(string: "https://www.example.com")!) { _, error in
            completionCalledWithError = error as NSError?
        }
        self.stubURLSession.dataTaskCalled?.completionHandler(nil, nil, raisedError)
        
        XCTAssertEqual(completionCalledWithError, raisedError)
    }
    
    func testRequestJSONCallsCompletionWithData() {
        let executer = RequestExecuter(urlSession: self.stubURLSession)
        var completionCalledWithData: Data?
        let data = Data()
        
        executer.requestJSON(url: URL(string: "https://www.example.com")!) { data, _ in
            completionCalledWithData = data
        }
        self.stubURLSession.dataTaskCalled?.completionHandler(data, nil, nil)
        
        XCTAssertEqual(completionCalledWithData, data)
    }
    
    func testRequestJSONDoesNotCallsCompletionWhenDataIsNil() {
        let executer = RequestExecuter(urlSession: self.stubURLSession)
        var completionCalled = false
        
        executer.requestJSON(url: URL(string: "https://www.example.com")!) { _, _ in
            completionCalled = true
        }
        self.stubURLSession.dataTaskCalled?.completionHandler(nil, nil, nil)
        
        XCTAssertFalse(completionCalled)
    }

}
