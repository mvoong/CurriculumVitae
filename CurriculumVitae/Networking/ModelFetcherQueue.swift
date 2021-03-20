//
//  ModelFetcherQueue.swift
//  CurriculumVitae
//
//  Created by Michael Voong on 05/02/2019.
//  Copyright © 2019 Meidi Limited. All rights reserved.
//

import Foundation

protocol ModelFetcherQueueProtocol {
    
    func enqueueRequest(request: NetworkRequestProtocol, completion: @escaping (Result<Data, RequestExecuterError>) -> Void)
}

class ModelFetcherQueue: ModelFetcherQueueProtocol {
    
    private let requestExecuter: RequestExecuterProtocol
    private var inFlightRequests = [NetworkRequestProtocol]()
    private var deferredRequests = [DeferredNetworkRequest]()
    
    init(requestExecuter: RequestExecuterProtocol) {
        self.requestExecuter = requestExecuter
    }
    
    func enqueueRequest(request: NetworkRequestProtocol, completion: @escaping (Result<Data, RequestExecuterError>) -> Void) {
        if self.isAuthInFlight() {
            self.deferRequest(DeferredNetworkRequest(request: request, completion: completion))
            return
        }
        self.startRequest(request, completion: completion)
    }
    
    private func isAuthInFlight() -> Bool {
        return self.inFlightRequests.contains { $0.type == .auth }
    }
    
    private func deferRequest(_ request: DeferredNetworkRequest) {
        self.deferredRequests.append(request)
    }
    
    private func startRequest(_ request: NetworkRequestProtocol, completion: @escaping (Result<Data, RequestExecuterError>) -> Void) {
        self.inFlightRequests.append(request)
        self.requestExecuter.requestData(url: request.url) { result in
            self.inFlightRequests.remove(request)
            completion(result)
            self.continueDeferredRequests()
        }
    }
    
    private func continueDeferredRequests() {
        for request in self.deferredRequests {
            self.deferredRequests.remove(request)
            self.enqueueRequest(request: request.request, completion: request.completion)
        }
    }
}
