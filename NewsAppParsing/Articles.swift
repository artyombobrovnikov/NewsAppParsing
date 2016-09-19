//
//  Articles.swift
//  NewsAppParsing
//
//  Created by Admin on 15.09.16.
//  Copyright © 2016 Bobrovnikov. All rights reserved.
//

import Foundation
import UIKit

struct Articles {
    
    
    var author: String = ""
    var title: String = ""
    var description: String = ""
    var url: String = ""
    var urlToImage: String = ""
    var publishedAt: String = ""

    var image: UIImage?
    
        
    
    init () {
        
        
        if let imageURL = NSURL(string: urlToImage), let imageData = NSData(contentsOf: imageURL as URL) {
            self.image = UIImage(data: imageData as Data)
    }

 }


}
 

