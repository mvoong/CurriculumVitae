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
    
    private(set) var requestJSONCalled: (url: URL, completion: (Data?, Error?) -> Void)?
    
    func requestJSON(url: URL, completion: @escaping (Data?, Error?) -> Void) {
        self.requestJSONCalled = (url, completion)
    }
}
