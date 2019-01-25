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
    
    // Hardcoded here, but this should be more dynamic in a real app
    private static let cv = "https://gist.githubusercontent.com/mvoong/c1e2368376c9b91b9e0cb6061f194526/raw/028ff182decbd95257a35e6d662e5dc6e68c7a29/cv.json"
    
    private let modelFetcher: ModelFetcherProtocol
    
    init(modelFetcher: ModelFetcherProtocol) {
        self.modelFetcher = modelFetcher
    }
    
    func requestCV(completion: @escaping (CurriculumVitae) -> Void) {
        self.modelFetcher.fetch(type: CurriculumVitae.self, url: URL(string: CVInteractor.cv)!) { cv, _ in
            if let cv = cv {
                completion(cv)
            }
        }
    }
}
