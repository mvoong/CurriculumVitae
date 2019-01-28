//
//  RequestExectuter.swift
//  CurriculumVitae
//
//  Created by Michael Voong on 24/01/2019.
//  Copyright © 2019 Meidi Limited. All rights reserved.
//

import Foundation

protocol RequestExecuterProtocol {
    
    func requestJSON(url: URL, completion: @escaping (RequestExecuter.Result) -> Void)
}

struct RequestExecuter: RequestExecuterProtocol {
    
    private let urlSession: URLSessionProtocol
    
    enum Result {
        
        case success(Data)
        case failure(Error)
    }
    
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func requestJSON(url: URL, completion: @escaping (Result) -> Void) {
        let task = self.urlSession.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                completion(.success(data))
            }
        }
        task.resume()
    }
}
