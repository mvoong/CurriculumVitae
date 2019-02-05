//
//  AssetFetcher.swift
//  CurriculumVitae
//
//  Created by Michael Voong on 28/01/2019.
//  Copyright © 2019 Meidi Limited. All rights reserved.
//

import UIKit

protocol AssetFetcherProtocol {
    
    func fetchImage(url: URL, completion: @escaping (UIImage) -> Void)
}

class AssetFetcher: AssetFetcherProtocol {

    static let shared = AssetFetcher(requestExecuter: RequestExecuter(urlSession: URLSession.shared))
    
    private let requestExecuter: RequestExecuterProtocol
    private let coalescingMonitor = URLCoalescingMonitor<UIImage>()
    
    init(requestExecuter: RequestExecuterProtocol) {
        self.requestExecuter = requestExecuter
    }
    
    func fetchImage(url: URL, completion: @escaping (UIImage) -> Void) {
        let isMonitoring = self.coalescingMonitor.isMonitoring(url: url)
        self.coalescingMonitor.monitor(url: url, completion: completion)
        
        if !isMonitoring {
            self.requestExecuter.requestData(url: url) { result in
                switch result {
                case .success(let data):
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.coalescingMonitor.complete(url: url, object: image)
                        }
                    }
                case .failure:
                    break
                }
            }
        }
    }
}
