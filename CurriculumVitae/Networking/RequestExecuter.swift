//
//  RequestExectuter.swift
//  CurriculumVitae
//
//  Created by Michael Voong on 24/01/2019.
//  Copyright © 2019 Meidi Limited. All rights reserved.
//

import Foundation

protocol RequestExecuterProtocol {
    
    func requestJSON(url: URL, completion: @escaping (Result<Data, RequestExecuter.RequestExecuterError>) -> Void)
}

struct RequestExecuter: RequestExecuterProtocol {
    
    enum RequestExecuterError: Error {
        
        case foundationError(Error)
    }
    
    private let urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func requestJSON(url: URL, completion: @escaping (Result<Data, RequestExecuterError>) -> Void) {
        let task = self.urlSession.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(.foundationError(error)))
                return
            }
            
            if let data = data {
                completion(.success(data))
            }
        }
        task.resume()
    }
}
