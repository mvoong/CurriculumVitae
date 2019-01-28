//
//  PastExperienceDate.swift
//  CurriculumVitae
//
//  Created by Michael Voong on 24/01/2019.
//  Copyright © 2019 Meidi Limited. All rights reserved.
//

import Foundation

struct PastExperienceDate: Decodable {
    
    // 1 = January, 12 = December
    let month: Int

    let year: Int
    
    func displayableDate() -> String {
        // In a real app we could pass in a date formatter for a more friendly string
        return "\(self.month) \(self.year)"
    }
}
