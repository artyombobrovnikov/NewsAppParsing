//
//  SourceTableViewCell.swift
//  NewsAppParsing
//
//  Created by Admin on 19.09.16.
//  Copyright © 2016 Bobrovnikov. All rights reserved.
//

import UIKit

class SourceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var LogosLabel: UIImageView!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var CountryLabel: UILabel!
    @IBOutlet weak var CategoryLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateWithImage(_ row: Int) {
        let image = UIImage(named: "\(row)")
        self.LogosLabel.image = image
    }
}
