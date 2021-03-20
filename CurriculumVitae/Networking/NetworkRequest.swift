//
//  NetworkRequest.swift
//  CurriculumVitae
//
//  Created by Michael Voong on 05/02/2019.
//  Copyright © 2019 Meidi Limited. All rights reserved.
//

import Foundation

protocol NetworkRequestProtocol {
    
    var url: URL { get }
    var type: NetworkRequestType { get }
}

enum NetworkRequestType {
    
    case normal
    case auth
}

struct NetworkRequest<T>: NetworkRequestProtocol where T: Decodable {
    
    let url: URL
    let type: NetworkRequestType
    let completion: (Result<T, ModelFetcherError>) -> Void
    
    init(url: URL, requestType: NetworkRequestType = .normal, completion: @escaping (Result<T, ModelFetcherError>) -> Void) {
        self.url = url
        self.type = requestType
        self.completion = completion
    }
}

extension Array where Element == NetworkRequestProtocol {
    
    mutating func remove(_ request: NetworkRequestProtocol) {
        self.removeAll { $0 == request }
    }
}

func == (lhs:  NetworkRequestProtocol, rhs: NetworkRequestProtocol) -> Bool {
    return lhs.url == rhs.url && lhs.type == rhs.type
}
