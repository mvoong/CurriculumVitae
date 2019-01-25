//
//  StubCVInteractor.swift
//  CurriculumVitaeTests
//
//  Created by Michael Voong on 25/01/2019.
//  Copyright © 2019 Meidi Limited. All rights reserved.
//

import Foundation
@testable import CurriculumVitae

class StubCVInteractor: CVInteractorProtocol {
    
    private(set) var requestCVCalledWithCompletion: ((CurriculumVitae) -> Void)?
    
    func requestCV(completion: @escaping (CurriculumVitae) -> Void) {
        self.requestCVCalledWithCompletion = completion
    }
}
