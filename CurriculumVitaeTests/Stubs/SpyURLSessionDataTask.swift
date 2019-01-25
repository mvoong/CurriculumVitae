//
//  SpyURLSessionDataTask.swift
//  CurriculumVitaeTests
//
//  Created by Michael Voong on 25/01/2019.
//  Copyright © 2019 Meidi Limited. All rights reserved.
//

import Foundation

class SpyURLSessionDataTask: URLSessionDataTask {
    
    private(set) var resumeCalled = false
    
    override func resume() {
        self.resumeCalled = true
    }
}
