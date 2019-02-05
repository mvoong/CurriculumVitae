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
    
    func testRequestDataCreatesDataTaskWithCorrectURL() {
        let executer = RequestExecuter(urlSession: self.stubURLSession)
        
        executer.requestData(url: URL(string: "https://www.example.com")!) { _ in }
        
        XCTAssertEqual(self.stubURLSession.dataTaskCalled?.url.absoluteString, "https://www.example.com")
    }
    
    func testRequestDataCallsResumeOnDataTask() {
        let executer = RequestExecuter(urlSession: self.stubURLSession)
        
        executer.requestData(url: URL(string: "https://www.example.com")!) { _ in }
        
        XCTAssertTrue(self.stubURLSession.spyDataTask.resumeCalled)
    }
    
    func testRequestDataCallsCompletionWithFoundationError() {
        let executer = RequestExecuter(urlSession: self.stubURLSession)
        var completionCalledWithResult: Result<Data, RequestExecuter.RequestExecuterError>?
        let raisedError = NSError(domain: "", code: 0, userInfo: nil)
        
        executer.requestData(url: URL(string: "https://www.example.com")!) { result in
            completionCalledWithResult = result
        }
        self.stubURLSession.dataTaskCalled?.completionHandler(nil, nil, raisedError)
        
        if case .failure(.foundationError(let error))? = completionCalledWithResult {
            XCTAssertEqual(error as NSError, raisedError)
        } else {
            XCTFail()
        }
    }
    
    func testRequestDataCallsCompletionWithData() {
        let executer = RequestExecuter(urlSession: self.stubURLSession)
        var completionCalledWithResult: Result<Data, RequestExecuter.RequestExecuterError>?
        let responseData = Data()
        
        executer.requestData(url: URL(string: "https://www.example.com")!) { result in
            completionCalledWithResult = result
        }
        self.stubURLSession.dataTaskCalled?.completionHandler(responseData, nil, nil)
        
        if case .success(let data)? = completionCalledWithResult {
            XCTAssertEqual(data, responseData)
        } else {
            XCTFail()
        }
    }
    
    func testRequestDataDoesNotCallsCompletionWhenDataIsNil() {
        let executer = RequestExecuter(urlSession: self.stubURLSession)
        var completionCalled = false
        
        executer.requestData(url: URL(string: "https://www.example.com")!) { _ in
            completionCalled = true
        }
        self.stubURLSession.dataTaskCalled?.completionHandler(nil, nil, nil)
        
        XCTAssertFalse(completionCalled)
    }

}
