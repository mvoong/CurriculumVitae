//
//  ModelFetcher.swift
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
    
    func fetch<T>(type: T.Type, request: NetworkRequest<T>) where T: Decodable
    func fetchCV(completion: @escaping (Result<CurriculumVitae, ModelFetcherError>) -> Void)
}

struct ModelFetcher: ModelFetcherProtocol {
    
    private let requestExecuter: RequestExecuterProtocol
    private let jsonDecoder = JSONDecoder()
    
    init(requestExecuter: RequestExecuterProtocol) {
        self.requestExecuter = requestExecuter
    }
    
    func fetch<T>(type: T.Type, request: NetworkRequest<T>) where T: Decodable {
        self.requestExecuter.requestData(url: request.url) { result in
            switch result {
            case .success(let data):
                do {
                    let model = try self.jsonDecoder.decode(T.self, from: data)
                    request.completion(.success(model))
                } catch {
                    request.completion(.failure(.decodingError))
                    
                }
            case .failure:
                request.completion(.failure(.networkError))
            }
        }
    }
    
    func fetchCV(completion: @escaping (Result<CurriculumVitae, ModelFetcherError>) -> Void) {
        let url = "https://gist.githubusercontent.com/mvoong/c1e2368376c9b91b9e0cb6061f194526/raw/028ff182decbd95257a35e6d662e5dc6e68c7a29/cv.json"
        let request = NetworkRequest(url: URL(string: url)!, completion: completion)
        self.fetch(type: CurriculumVitae.self, request: request)
    }
}
