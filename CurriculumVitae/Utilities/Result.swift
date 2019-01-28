//
//  Result.swift
//  CurriculumVitae
//
//  Created by Michael Voong on 28/01/2019.
//  Copyright © 2019 Meidi Limited. All rights reserved.
//

import Foundation

enum Result<T, E> where E: Error {
    
    case success(T)
    case failure(E)
}
