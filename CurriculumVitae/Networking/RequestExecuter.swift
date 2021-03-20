//
//  RequestExectuter.swift
//  CurriculumVitae
//
//  Created by Michael Voong on 24/01/2019.
//  Copyright © 2019 Meidi Limited. All rights reserved.
//

import Foundation

protocol RequestExecuterProtocol {
    
    func requestData(url: URL, completion: @escaping (Result<Data, RequestExecuterError>) -> Void)
}

enum RequestExecuterError: Error {
    
    case foundationError(Error)
}

struct RequestExecuter: RequestExecuterProtocol {
    
    private let urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol) {
        self.urlSession = urlSession
    }
    
    func requestData(url: URL, completion: @escaping (Result<Data, RequestExecuterError>) -> Void) {
        let task = self.urlSession.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(.foundationError(error)))
                    return
                }
                
                if let data = data {
                    completion(.success(data))
                }
            }
        }
        task.resume()
    }
}
