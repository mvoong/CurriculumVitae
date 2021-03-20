//
//  DeferredNetworkRequest.swift
//  CurriculumVitae
//
//  Created by Michael Voong on 05/02/2019.
//  Copyright © 2019 Meidi Limited. All rights reserved.
//

import Foundation

struct DeferredNetworkRequest {
    
    let request: NetworkRequestProtocol
    let completion: (Result<Data, RequestExecuterError>) -> Void
}

extension Array where Element == DeferredNetworkRequest {
    
    mutating func remove(_ request: DeferredNetworkRequest) {
        self.removeAll { $0 == request }
    }
}

func == (lhs:  DeferredNetworkRequest, rhs: DeferredNetworkRequest) -> Bool {
    return lhs.request == rhs.request
}

