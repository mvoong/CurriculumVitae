//
//  CurriculumVitaeRequest.swift
//  CurriculumVitae
//
//  Created by Michael Voong on 24/01/2019.
//  Copyright © 2019 Meidi Limited. All rights reserved.
//

import Foundation

enum ModelFetcherError: Error {
    
    case networkError
    case decodingError
}

protocol ModelFetcherProtocol {
    
    func fetch<T>(type: T.Type, url: URL, completion: @escaping (T?, Error?) -> Void) where T: Decodable
}

struct ModelFetcher {
    
    private let requestExecuter: RequestExecuterProtocol
    private let jsonDecoder = JSONDecoder()
    
    init(requestExecuter: RequestExecuterProtocol) {
        self.requestExecuter = requestExecuter
    }
    
    func fetch<T>(type: T.Type, url: URL, completion: @escaping (T?, ModelFetcherError?) -> Void) where T: Decodable {
        self.requestExecuter.requestJSON(url: url) { data, error in
            if error != nil {
                completion(nil, .networkError)
                return
            }
            
            if let data = data {
                do {
                    let model = try self.jsonDecoder.decode(T.self, from: data)
                    completion(model, nil)
                } catch {
                  completion(nil, .decodingError)
                }
            }
        }
    }
}
