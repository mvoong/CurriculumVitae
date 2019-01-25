//
//  StubURLSession.swift
//  CurriculumVitaeTests
//
//  Created by Michael Voong on 25/01/2019.
//  Copyright © 2019 Meidi Limited. All rights reserved.
//

import Foundation
@testable import CurriculumVitae

class StubURLSession: URLSessionProtocol {
    
    private(set) var dataTaskCalled: (url: URL, completionHandler: (Data?, URLResponse?, Error?) -> Void)?
    let spyDataTask = SpyURLSessionDataTask()
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.dataTaskCalled = (url, completionHandler)
        return self.spyDataTask
    }
}
