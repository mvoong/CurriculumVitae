//
//  CurriculumVitae.swift
//  CurriculumVitae
//
//  Created by Michael Voong on 24/01/2019.
//  Copyright © 2019 Meidi Limited. All rights reserved.
//

import Foundation

struct CurriculumVitae: Codable {
    
    let summary: String
    let topics: String
    let pastExperience: [PastExperience]
}
