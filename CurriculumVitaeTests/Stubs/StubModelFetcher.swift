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
    
    private(set) var fetchCalled: (url: URL, completion: (Result<Decodable, ModelFetcher.ModelFetcherError>) -> Void)?
    
    func fetch<T>(type: T.Type, url: URL, completion: @escaping (Result<T, ModelFetcher.ModelFetcherError>) -> Void) where T : Decodable {
        self.fetchCalled = (url, { result in
            switch result {
            case .success(let object):
                completion(.success(object as! T))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
