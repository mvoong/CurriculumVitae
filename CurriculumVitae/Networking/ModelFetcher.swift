//
//  ModelFetcher.swift
//  CurriculumVitae
//
//  Created by Michael Voong on 24/01/2019.
//  Copyright © 2019 Meidi Limited. All rights reserved.
//

import Foundation

protocol ModelFetcherProtocol {
    
    func fetch<T>(type: T.Type, url: URL, completion: @escaping (Result<T, ModelFetcher.ModelFetcherError>) -> Void) where T: Decodable
}

struct ModelFetcher: ModelFetcherProtocol {

    enum ModelFetcherError: Error {
        
        case networkError
        case decodingError
    }
    
    private let requestExecuter: RequestExecuterProtocol
    private let jsonDecoder = JSONDecoder()
    
    init(requestExecuter: RequestExecuterProtocol) {
        self.requestExecuter = requestExecuter
    }
    
    func fetch<T>(type: T.Type, url: URL, completion: @escaping (Result<T, ModelFetcherError>) -> Void) where T: Decodable {
        self.requestExecuter.requestJSON(url: url) { result in
            switch result {
            case .success(let data):
                do {
                    let model = try self.jsonDecoder.decode(T.self, from: data)
                    completion(.success(model))
                } catch {
                    completion(.failure(.decodingError))
                    
                }
            case .failure:
                completion(.failure(.networkError))
            }
        }
    }
}
