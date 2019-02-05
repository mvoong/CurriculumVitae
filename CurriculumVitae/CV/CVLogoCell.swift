//
//  CVLogoCell.swift
//  CurriculumVitae
//
//  Created by Michael Voong on 28/01/2019.
//  Copyright © 2019 Meidi Limited. All rights reserved.
//

import UIKit

class CVLogoCell: UITableViewCell {
    
    @IBOutlet private weak var logoImageView: UIImageView?
    
    func setLogo(url: URL, assetFetcher: AssetFetcherProtocol) {
        assetFetcher.fetchImage(url: url) { [weak self] image in
            self?.logoImageView?.image = image
        }
    }
}
