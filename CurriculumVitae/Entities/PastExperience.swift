//
//  PastExperience.swift
//  CurriculumVitae
//
//  Created by Michael Voong on 24/01/2019.
//  Copyright © 2019 Meidi Limited. All rights reserved.
//

import Foundation

struct PastExperience: Decodable {
    
    let companyName: String
    let companyLogoURL: String
    let roleName: String
    let dateFrom: PastExperienceDate
    let dateTo: PastExperienceDate
    let description: String
}
