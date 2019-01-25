//
//  UITableView+Helper.swift
//  CurriculumVitae
//
//  Created by Michael Voong on 25/01/2019.
//  Copyright © 2019 Meidi Limited. All rights reserved.
//

import UIKit

extension UITableView {
    
    // Convenience method to dequeue cells without having to force cast everywhere
    func dequeueReusableCell<T>(type: T.Type, identifier: String, indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            fatalError("Cannot dequeue cell with identifier: \(identifier)")
        }
        return cell
    }
}
