//
//  CVDescriptionCell.swift
//  CurriculumVitae
//
//  Created by Michael Voong on 25/01/2019.
//  Copyright © 2019 Meidi Limited. All rights reserved.
//

import UIKit

class CVDescriptionCell: UITableViewCell {
    
    @IBOutlet private weak var label: UILabel?
    
    func setText(_ text: String) {
        self.label?.text = text
    }
}
