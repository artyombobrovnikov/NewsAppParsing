//
//  ArticlesTableViewCell.swift
//  NewsAppParsing
//
//  Created by Admin on 15.09.16.
//  Copyright © 2016 Bobrovnikov. All rights reserved.
//

import UIKit

class ArticlesTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var PublishedAtLabel: UILabel!
    @IBOutlet weak var ImageLabel: UIImageView!
    
      
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}


