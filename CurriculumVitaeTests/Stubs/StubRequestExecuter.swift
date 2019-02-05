//
//  StubRequestExecuter.swift
//  CurriculumVitaeTests
//
//  Created by Michael Voong on 25/01/2019.
//  Copyright © 2019 Meidi Limited. All rights reserved.
//

import Foundation
@testable import CurriculumVitae

class StubRequestExecuter: RequestExecuterProtocol {
    
    private(set) var requestDataCalled: (url: URL, completion: (Result<Data, RequestExecuter.RequestExecuterError>) -> Void)?
    
    func requestData(url: URL, completion: @escaping (Result<Data, RequestExecuter.RequestExecuterError>) -> Void) {
        self.requestDataCalled = (url, completion)
    }
}
