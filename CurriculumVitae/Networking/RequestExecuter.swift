//
//  RequestExectuter.swift
//  CurriculumVitae
//
//  Created by Michael Voong on 24/01/2019.
//  Copyright © 2019 Meidi Limited. All rights reserved.
//

import Foundation

protocol RequestExecuterProtocol {
    
    func requestJSON(url: URL, completion: @escaping (Data?, Error?) -> Void)
}

struct RequestExecuter: RequestExecuterProtocol {
    
    private let urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func requestJSON(url: URL, completion: @escaping (Data?, Error?) -> Void) {
        let task = self.urlSession.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let data = data {
                completion(data, nil)
            }
        }
        task.resume()
    }
}
