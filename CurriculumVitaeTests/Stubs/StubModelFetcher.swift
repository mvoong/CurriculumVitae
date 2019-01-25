//
//  StubModelFetcher.swift
//  CurriculumVitaeTests
//
//  Created by Michael Voong on 25/01/2019.
//  Copyright © 2019 Meidi Limited. All rights reserved.
//

import Foundation
@testable import CurriculumVitae

class StubModelFetcher: ModelFetcherProtocol {
    
    private(set) var fetchCalled: (url: URL, completion: (Decodable?, ModelFetcherError?) -> Void)?
    
    func fetch<T>(type: T.Type, url: URL, completion: @escaping (T?, ModelFetcherError?) -> Void) where T : Decodable {
        self.fetchCalled = (url, { object, error in
            completion(object as? T, error)
        })
    }
}
