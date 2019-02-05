//
//  NetworkRequest.swift
//  CurriculumVitae
//
//  Created by Michael Voong on 05/02/2019.
//  Copyright © 2019 Meidi Limited. All rights reserved.
//

import Foundation

struct NetworkRequest<T> where T: Decodable {
    
    enum RequestType {
        
        case normal
        case auth
    }
    
    let url: URL
    let type: RequestType
    let completion: (Result<T, ModelFetcherError>) -> Void
    
    init(url: URL, requestType: RequestType = .normal, completion: @escaping (Result<T, ModelFetcherError>) -> Void) {
        self.url = url
        self.type = requestType
        self.completion = completion
    }
}
