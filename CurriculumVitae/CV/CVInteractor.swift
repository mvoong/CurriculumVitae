//
//  CVInteractor.swift
//  CurriculumVitae
//
//  Created by Michael Voong on 25/01/2019.
//  Copyright © 2019 Meidi Limited. All rights reserved.
//

import Foundation

protocol CVInteractorProtocol {
    
    func requestCV(completion: @escaping (CurriculumVitae) -> Void)
}

class CVInteractor: CVInteractorProtocol {
    
    private let modelFetcher: ModelFetcherProtocol
    
    init(modelFetcher: ModelFetcherProtocol) {
        self.modelFetcher = modelFetcher
    }
    
    func requestCV(completion: @escaping (CurriculumVitae) -> Void) {
        self.modelFetcher.fetchCV { result in
            switch result {
            case .success(let cv):
                completion(cv)
            case .failure:
                // To implement: call back to view controller to show error to user
                break
            }
        }
    }
}
