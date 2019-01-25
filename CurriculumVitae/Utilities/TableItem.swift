//
//  TableItem.swift
//  CurriculumVitae
//
//  Created by Michael Voong on 25/01/2019.
//  Copyright © 2019 Meidi Limited. All rights reserved.
//

import UIKit

protocol TableItem {
    
    func dequeueCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}
