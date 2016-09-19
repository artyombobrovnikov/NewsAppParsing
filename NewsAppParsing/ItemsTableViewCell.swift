//
//  ItemsTableViewCell.swift
//  NewsAppParsing
//
//  Created by Admin on 15.09.16.
//  Copyright © 2016 Bobrovnikov. All rights reserved.
//

import UIKit

class ItemsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var PublishedAtLabel: UILabel!
    @IBOutlet weak var ImageLabel: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func updateWithImage(_ row: Int) {
        
        let image = UIImage(named: "\(row)")
        
        self.ImageLabel.image = image

       
}
}


